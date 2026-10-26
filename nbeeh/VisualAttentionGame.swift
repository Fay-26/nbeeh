//
//  VisualAttentionGame.swift
//  nbeeh
//
//  Created by Monerah Almousa on 11/05/1448 AH.
//


import SwiftUI

// MARK: - Shape Types

private enum GameShape: CaseIterable {
    case circle
    case triangle
    case square
}

// MARK: - Game Tile

private struct GameTile: Identifiable {
    let id = UUID()
    let shape: GameShape
    let colorIndex: Int
}

// MARK: - Main Game

struct VisualAttentionGame: View {

    @Environment(\.dismiss) private var dismiss

    // Difficulty is saved between sessions
    @AppStorage("visualAttentionDifficulty")
    private var difficultyLevel = 0

    // Five rounds per session
    @State private var roundNumber = 1
    @State private var boardTiles: [GameTile] = []
    @State private var targetShape: GameShape = .triangle
    @State private var isFinished = false

    // Hidden performance tracking
    @State private var roundStart = Date()
    @State private var reactionTimes: [Double] = []
    @State private var correctAnswers = 0
    @State private var totalErrors = 0

    // Adaptive difficulty
    @State private var fastCorrectStreak = 0
    @State private var consecutiveErrors = 0

    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 12),
        count: 3
    )

    var body: some View {

        ZStack {
            Color("mainBG")
                .ignoresSafeArea()

            VStack(spacing: 0) {

                // MARK: Header

                HStack {

                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 30, weight: .semibold))
                            .foregroundStyle(Color("mainBG"))
                            .frame(width: 48, height: 48)
                            .background(
                                Color("box"),
                                in: Circle()
                            )
                    }
                    .buttonStyle(.plain)

                    Spacer()

                    Text("تحدي الانتباه البصري")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(Color("mainBG"))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            Color("box"),
                            in: RoundedRectangle(cornerRadius: 12)
                        )

                    Spacer()

                    Image(systemName: "eye")
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundStyle(Color("box"))
                }
                .padding(.horizontal, 18)
                .padding(.top, 16)

                Spacer(minLength: 18)

                // MARK: Game Board

                ZStack {

                    Color.white

                    if isFinished {

                        Text("انتهت الجولات الخمس!")
                            .font(.system(size: 25, weight: .semibold))
                            .foregroundStyle(Color("mainBG"))
                            .multilineTextAlignment(.center)
                            .padding()

                    } else {

                        LazyVGrid(
                            columns: columns,
                            spacing: 50
                        ) {

                            ForEach(boardTiles) { tile in

                                Button {
                                    selectShape(tile)
                                } label: {

                                    ShapeView(tile: tile)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 42)
                                        .contentShape(Rectangle())
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 18)
                        .padding(.vertical, 22)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 520)
                .clipShape(
                    RoundedRectangle(cornerRadius: 50)
                )
                .padding(.horizontal, 18)

                Spacer(minLength: 18)
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {
            startSession()
        }
    }


    private func startSession() {

        roundNumber = 1
        isFinished = false

        reactionTimes = []
        correctAnswers = 0
        totalErrors = 0

        fastCorrectStreak = 0
        consecutiveErrors = 0

        generateChallenge()
    }


    
    private func generateChallenge() {
        targetShape = GameShape.allCases.randomElement() ?? .triangle

        let distractors = GameShape.allCases
            .filter { $0 != targetShape }
            .shuffled()

        var newTiles: [GameTile] = []

        newTiles.append(
            GameTile(
                shape: targetShape,
                colorIndex: Int.random(in: 0...1)
            )
        )

        let distractorTypeCount = Int.random(in: 1...2)

        if distractorTypeCount == 1 {
            let shape = distractors[0]
            let color = Int.random(in: 0...1)

            for _ in 0..<14 {
                newTiles.append(
                    GameTile(
                        shape: shape,
                        colorIndex: color
                    )
                )
            }
        } else {
            let firstShape = distractors[0]
            let secondShape = distractors[1]

            let firstCount = Int.random(in: 5...9)
            let secondCount = 14 - firstCount

            let firstColor = Int.random(in: 0...1)
            let secondColor = Int.random(in: 0...1)

            for _ in 0..<firstCount {
                newTiles.append(
                    GameTile(
                        shape: firstShape,
                        colorIndex: firstColor
                    )
                )
            }

            for _ in 0..<secondCount {
                newTiles.append(
                    GameTile(
                        shape: secondShape,
                        colorIndex: secondColor
                    )
                )
            }
        }

        boardTiles = newTiles.shuffled()

        roundStart = Date()
    }



    private func selectShape(_ tile: GameTile) {

        guard !isFinished else { return }

        let elapsed = Date().timeIntervalSince(roundStart)
        reactionTimes.append(elapsed)

        if tile.shape == targetShape {

            correctAnswers += 1
            consecutiveErrors = 0

            if elapsed <= 2.5 {
                fastCorrectStreak += 1
            } else {
                fastCorrectStreak = 0
            }

            if fastCorrectStreak >= 2 {
                difficultyLevel = min(difficultyLevel + 1, 8)
                fastCorrectStreak = 0
            }

        } else {

            totalErrors += 1
            consecutiveErrors += 1
            fastCorrectStreak = 0

            if consecutiveErrors >= 2 {
                difficultyLevel = max(difficultyLevel - 1, 0)
                consecutiveErrors = 0
            }
        }

        if roundNumber < 5 {

            roundNumber += 1
            generateChallenge()

        } else {

            isFinished = true

            print("Session completed")
            print("Correct answers: \(correctAnswers)")
            print("Total errors: \(totalErrors)")
            print("Reaction times: \(reactionTimes)")
            print("Saved difficulty: \(difficultyLevel)")
        }
    }
}


private struct ShapeView: View {

    let tile: GameTile

    var body: some View {

        GeometryReader { geometry in

            let side = min(
                geometry.size.width * 0.85,
                geometry.size.height * 0.9
            )

            Group {

                switch tile.shape {

                case .circle:
                    Circle()
                        .fill(shapeColor)

                case .triangle:
                    Triangle()
                        .fill(shapeColor)

                case .square:
                    Rectangle()
                        .fill(shapeColor)
                }
            }
            .frame(width: side, height: side)
            .frame(
                width: geometry.size.width,
                height: geometry.size.height
            )
        }
    }

    private var shapeColor: Color {
        tile.colorIndex == 0
            ? Color("botton")
            : Color("mainBG")
    }
}


private struct Triangle: Shape {

    func path(in rect: CGRect) -> Path {

        var path = Path()

        path.move(
            to: CGPoint(x: rect.midX, y: rect.minY)
        )

        path.addLine(
            to: CGPoint(x: rect.maxX, y: rect.maxY)
        )

        path.addLine(
            to: CGPoint(x: rect.minX, y: rect.maxY)
        )

        path.closeSubpath()

        return path
    }
}

#Preview {
    NavigationStack {
        VisualAttentionGame()
    }
}
