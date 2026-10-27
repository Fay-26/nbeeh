//
//  Untitled.swift
//  nbeeh
//
//  Created by Jumanah on 14/05/1448 AH.
//
import SwiftUI

struct MapView: View {

    // MARK: - Navigation

    @State private var selectedTab: Tab = .levels
    @State private var selectedLevel: Int?

    // MARK: - Identity Colors

    private let bg = Color("mainBG")
    private let surface = Color("taskBG")
    private let soft = Color("box")
    private let accent = Color("botton")
    private let textPrimary = Color("textbig")
    private let textSecondary = Color("textsmall")
    private let textDark = Color("textsmalldark")

    // MARK: - Progress Data

    // Temporary values until connected to user progress
    private let currentLevel = 2
    private let totalLevels = 7

    // MARK: - Map Dimensions

    private let mapHeight: CGFloat = 680

    // Positions from bottom (level 1) to top (level 7)

    private let stops: [CGPoint] = [
        CGPoint(x: 0.28, y: 0.91), // Level 1
        CGPoint(x: 0.72, y: 0.78), // Level 2
        CGPoint(x: 0.28, y: 0.65), // Level 3
        CGPoint(x: 0.72, y: 0.52), // Level 4
        CGPoint(x: 0.28, y: 0.39), // Level 5
        CGPoint(x: 0.72, y: 0.26), // Level 6
        CGPoint(x: 0.40, y: 0.13)  // Level 7
    ]

    // MARK: - Main View

    var body: some View {

        NavigationStack {

            ZStack {

                bg
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {

                    VStack(spacing: 0) {

                        // MARK: Header

                        HStack {

                            Text("7 مستويات")
                                .font(
                                    .system(
                                        size: 12,
                                        weight: .medium
                                    )
                                )
                                .foregroundStyle(textSecondary)

                            Spacer()

                            Text("خريطة المستويات")
                                .font(
                                    .system(
                                        size: 24,
                                        weight: .bold
                                    )
                                )
                                .foregroundStyle(textPrimary)
                        }
                        .padding(.top, 12)

                        // MARK: Map

                        mapSection
                            .padding(.top, 4)
                    }
                    .frame(maxWidth: 430)
                    .padding(.horizontal, 22)
                    .frame(maxWidth: .infinity)
                }
            }

            // MARK: - Custom Tab Bar
            // Unchanged

            .safeAreaInset(edge: .bottom, spacing: 0) {

                CustomTabBar(selectedTab: $selectedTab)
                    .padding(.bottom, 8)
            }

            .toolbar(.hidden, for: .navigationBar)
        }

        // MARK: - Navigation Destinations

        .fullScreenCover(
            isPresented: Binding(
                get: {
                    selectedTab == .home
                },
                set: {
                    if !$0 {
                        selectedTab = .levels
                    }
                }
            )
        ) {
            HomeView()
        }

        .fullScreenCover(
            isPresented: Binding(
                get: {
                    selectedTab == .performance
                },
                set: {
                    if !$0 {
                        selectedTab = .levels
                    }
                }
            )
        ) {
            WeeklyPerformanceView()
        }

        // MARK: - Level Selection

        .alert(
            "المستوى \(selectedLevel ?? 1)",
            isPresented: Binding(
                get: {
                    selectedLevel != nil
                },
                set: {
                    if !$0 {
                        selectedLevel = nil
                    }
                }
            )
        ) {

            Button("حسنًا", role: .cancel) {
                selectedLevel = nil
            }

        } message: {

            Text("سيتم ربط هذه المحطة بالتحدي الخاص بها.")
        }
    }

    // MARK: - Map Section

    private var mapSection: some View {

        GeometryReader { geometry in

            let width = geometry.size.width

            ZStack {

                // MARK: Base Route

                routePath(
                    in: CGSize(
                        width: width,
                        height: mapHeight
                    )
                )
                .stroke(
                    soft.opacity(0.22),
                    style: StrokeStyle(
                        lineWidth: 23,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )

                // MARK: Inner Route

                routePath(
                    in: CGSize(
                        width: width,
                        height: mapHeight
                    )
                )
                .stroke(
                    soft.opacity(0.7),
                    style: StrokeStyle(
                        lineWidth: 13,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )

                // MARK: Completed Route

                completedRoute(
                    in: CGSize(
                        width: width,
                        height: mapHeight
                    )
                )
                .stroke(
                    accent,
                    style: StrokeStyle(
                        lineWidth: 13,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )

                // MARK: Stations

                ForEach(
                    1...totalLevels,
                    id: \.self
                ) { level in

                    let point = stops[level - 1]

                    station(level)
                        .position(
                            x: width * point.x,
                            y: mapHeight * point.y
                        )
                }

                // MARK: Destination Flag

                Image(systemName: "flag.checkered")
                    .font(
                        .system(
                            size: 21,
                            weight: .medium
                        )
                    )
                    .foregroundStyle(textPrimary)
                    .position(
                        x: width * 0.40,
                        y: mapHeight * 0.045
                    )
            }
            .frame(
                width: width,
                height: mapHeight
            )
        }
        .frame(height: mapHeight)
    }

    // MARK: - Route Drawing

    private func routePath(
        in size: CGSize
    ) -> Path {

        Path { path in

            guard let first = stops.first else {
                return
            }

            path.move(
                to: CGPoint(
                    x: first.x * size.width,
                    y: first.y * size.height
                )
            )

            for index in 0..<(stops.count - 1) {

                let start = CGPoint(
                    x: stops[index].x * size.width,
                    y: stops[index].y * size.height
                )

                let end = CGPoint(
                    x: stops[index + 1].x * size.width,
                    y: stops[index + 1].y * size.height
                )

                let middleY = (
                    start.y + end.y
                ) / 2

                path.addCurve(
                    to: end,
                    control1: CGPoint(
                        x: start.x,
                        y: middleY
                    ),
                    control2: CGPoint(
                        x: end.x,
                        y: middleY
                    )
                )
            }
        }
    }

    // MARK: - Completed Route

    private func completedRoute(
        in size: CGSize
    ) -> Path {

        Path { path in

            guard currentLevel > 1 else {
                return
            }

            let first = stops[0]

            path.move(
                to: CGPoint(
                    x: first.x * size.width,
                    y: first.y * size.height
                )
            )

            let lastCompletedSegment = min(
                currentLevel,
                totalLevels
            ) - 1

            for index in 0..<lastCompletedSegment {

                let start = CGPoint(
                    x: stops[index].x * size.width,
                    y: stops[index].y * size.height
                )

                let end = CGPoint(
                    x: stops[index + 1].x * size.width,
                    y: stops[index + 1].y * size.height
                )

                let middleY = (
                    start.y + end.y
                ) / 2

                path.addCurve(
                    to: end,
                    control1: CGPoint(
                        x: start.x,
                        y: middleY
                    ),
                    control2: CGPoint(
                        x: end.x,
                        y: middleY
                    )
                )
            }
        }
    }

    // MARK: - Station

    private func station(
        _ level: Int
    ) -> some View {

        let completed = level < currentLevel
        let current = level == currentLevel
        let locked = level > currentLevel

        return Button {

            if !locked {
                selectedLevel = level
            }

        } label: {

            VStack(spacing: 7) {

                ZStack {

                    // Current Level Highlight

                    if current {

                        Circle()
                            .stroke(
                                accent.opacity(0.28),
                                lineWidth: 9
                            )
                            .frame(
                                width: 91,
                                height: 91
                            )
                    }

                    // Station Background

                    Circle()
                        .fill(
                            current
                            ? accent
                            : completed
                            ? soft
                            : surface
                        )
                        .frame(
                            width: current ? 72 : 60,
                            height: current ? 72 : 60
                        )

                    // Station Border

                    Circle()
                        .stroke(
                            current
                            ? textPrimary.opacity(0.65)
                            : soft.opacity(0.8),
                            lineWidth: 2
                        )
                        .frame(
                            width: current ? 72 : 60,
                            height: current ? 72 : 60
                        )

                    // Station Content

                    if completed {

                        Image(
                            systemName: "checkmark"
                        )
                        .font(
                            .system(
                                size: 25,
                                weight: .bold
                            )
                        )
                        .foregroundStyle(textDark)

                    } else if locked {

                        Image(
                            systemName: "lock.fill"
                        )
                        .font(
                            .system(size: 18)
                        )
                        .foregroundStyle(
                            textSecondary.opacity(0.7)
                        )

                    } else {

                        Text("\(level)")
                            .font(
                                .system(
                                    size: 28,
                                    weight: .bold
                                )
                            )
                            .foregroundStyle(textPrimary)
                    }
                }

                // MARK: Station Labels

                VStack(spacing: 3) {

                    Text("المستوى \(level)")
                        .font(
                            .system(
                                size: 12,
                                weight: .bold
                            )
                        )
                        .foregroundStyle(textPrimary)

                    if current {

                        Text("أنت هنا")
                            .font(
                                .system(
                                    size: 10,
                                    weight: .semibold
                                )
                            )
                            .foregroundStyle(textPrimary)
                            .padding(
                                .horizontal,
                                10
                            )
                            .padding(
                                .vertical,
                                4
                            )
                            .background(
                                Capsule()
                                    .fill(accent)
                            )

                    } else if completed {

                        Text("مكتمل")
                            .font(
                                .system(size: 10)
                            )
                            .foregroundStyle(textSecondary)
                    }
                }
            }
            .frame(
                width: 112,
                height: 120
            )
        }
        .buttonStyle(.plain)
        .disabled(locked)
    }
}

// MARK: - Preview

#Preview {
    MapView()
}
