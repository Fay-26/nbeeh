//
//  VisualAttentionGame.swift
//  nbeeh
//
//  Created by Monerah Almousa on 11/05/1448 AH.
//

import SwiftUI

enum GameShape {
    case circle
    case triangle
    case square
}

struct GameTile: Identifiable {
    let id = UUID()
    let shape: GameShape
    let isDifferentColor: Bool
}


struct GameStage {
    let circles: Int
    let triangles: Int
    let squares: Int
    let highlightedTriangles: Int
    let highlightedSquares: Int
    let requiredTaps: Int

    var tiles: [GameTile] {
        var result: [GameTile] = []

        for _ in 0..<circles {
            result.append(
                GameTile(
                    shape: .circle,
                    isDifferentColor: false
                )
            )
        }

        for index in 0..<triangles {
            result.append(
                GameTile(
                    shape: .triangle,
                    isDifferentColor: index < highlightedTriangles
                )
            )
        }

        for index in 0..<squares {
            result.append(
                GameTile(
                    shape: .square,
                    isDifferentColor: index < highlightedSquares
                )
            )
        }

        return result
    }
}


struct VisualAttentionGame: View {

    @Environment(\.dismiss) private var dismiss

    private let stages: [GameStage] = [
        GameStage(
            circles: 14, triangles: 1, squares: 0,
            highlightedTriangles: 1, highlightedSquares: 0,
            requiredTaps: 1
        ),
        GameStage(
            circles: 13, triangles: 1, squares: 1,
            highlightedTriangles: 1, highlightedSquares: 1,
            requiredTaps: 2
        ),
        GameStage(
            circles: 11, triangles: 2, squares: 2,
            highlightedTriangles: 1, highlightedSquares: 1,
            requiredTaps: 4
        ),
        GameStage(
            circles: 10, triangles: 3, squares: 2,
            highlightedTriangles: 0, highlightedSquares: 0,
            requiredTaps: 5
        ),
        GameStage(
            circles: 9, triangles: 3, squares: 3,
            highlightedTriangles: 0, highlightedSquares: 0,
            requiredTaps: 6
        )
    ]

    @State private var stageIndex = 0
    @State private var boardShapes: [GameTile] = []

    @State private var tapsInStage = 0
    @State private var errorsInStage = 0
    @State private var totalErrors = 0
    @State private var stageStart = Date()
    @State private var reactionTimes: [Double] = []
    @State private var isFinished = false

    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 12),
        count: 3
    )

    private var currentStage: GameStage {
        stages[stageIndex]
    }

    var body: some View {
        ZStack {
            Color("taskBG")
                .ignoresSafeArea()

            VStack(spacing: 0) {

                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(
                                .system(size: 30, weight: .semibold)
                            )
                            .foregroundStyle(Color("taskBG"))
                            .frame(width: 48, height: 48)
                            .background(
                                Color("box"),
                                in: Circle()
                            )
                    }
                    .buttonStyle(.plain)

                    Spacer()

                    Text("تحدي الإنتباه البصري")
                        .font(
                            .system(size: 20, weight: .semibold)
                        )
                        .foregroundStyle(Color("mainBG"))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            Color("box"),
                            in: RoundedRectangle(cornerRadius: 12)
                        )

                    Spacer()

                    Image(systemName: "eye")
                        .font(
                            .system(size: 30, weight: .semibold)
                        )
                        .foregroundStyle(Color("box"))
                }
                .padding(.horizontal, 18)
                .padding(.top, 12)

                Spacer(minLength: 18)

                LazyVGrid(columns: columns, spacing: 38) {
                    ForEach(boardShapes) { tile in
                        Button {
                            selectShape(tile)
                        } label: {
                            ShapeView(tile: tile)
                                .frame(maxWidth: .infinity)
                                .frame(height: 68)
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 18)
                .padding(.vertical, 28)
                .frame(maxWidth: .infinity)
                .frame(height: 600)
                .background(Color.textbig)
                .clipShape(
                    RoundedRectangle(cornerRadius: 50)
                )
                .padding(.horizontal, 18)

                Spacer()
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {
            startStage()
        }
    }


    private func startStage() {
        boardShapes = currentStage.tiles.shuffled()
        tapsInStage = 0
        errorsInStage = 0
        stageStart = Date()
    }


    private func selectShape(_ tile: GameTile) {
        guard !isFinished else { return }

        tapsInStage += 1

        if tile.shape == .circle {
            errorsInStage += 1
            totalErrors += 1
        }

        if tapsInStage >= currentStage.requiredTaps {
            let elapsed = Date().timeIntervalSince(stageStart)
            reactionTimes.append(elapsed)

            if stageIndex < stages.count - 1 {
                stageIndex += 1
                startStage()
            } else {
                isFinished = true

                // No results page yet
                print("All five stages completed")
                print("Total errors: \(totalErrors)")
                print("Stage times: \(reactionTimes)")
            }
        }
    }
}


struct ShapeView: View {
    let tile: GameTile
    
    var body: some View {
        GeometryReader { geometry in
            let side = min(
                geometry.size.width * 0.45,
                geometry.size.height * 0.6
            )
            
            
            Group {
                switch tile.shape {
                case .circle:
                    Circle()
                        .fill(
                            tile.isDifferentColor
                            ? Color("mainBG")
                            : Color("botton")
                        )
                    
                case .triangle:
                    Triangle()
                        .fill(
                            tile.isDifferentColor
                            ? Color("mainBG")
                            : Color("botton")
                        )
                    
                case .square:
                    Rectangle()
                        .fill(
                            tile.isDifferentColor
                            ? Color("mainBG")
                            : Color("botton")
                        )
                }
            }
            .frame(width: side, height: side)
            .frame(
                width: geometry.size.width,
                height: geometry.size.height
            )
        }
    }
    struct Triangle: Shape {
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
}
 
