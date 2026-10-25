//
//  Untitled.swift
//  nbeeh
//
//  Created by Jumanah on 14/05/1448 AH.
//
import SwiftUI

struct MapView: View {

    // MARK: - Navigation

    @State private var selectedTab = 1

    // MARK: - Design Size

    private let designWidth: CGFloat = 402
    private let designHeight: CGFloat = 874

    // MARK: - Colors

    private let backgroundColor = Color("mainBG")

    private let stageColor = Color(
        red: 0.49,
        green: 0.36,
        blue: 0.51
    )

    private let roadColor = Color(
        red: 0.77,
        green: 0.67,
        blue: 0.79
    )

    private let firstStageColor = Color(
        red: 0.91,
        green: 0.90,
        blue: 0.92
    )

    private let sparkleColor = Color(
        red: 1.0,
        green: 0.85,
        blue: 0.20
    )

    // MARK: - Stage Positions

    // مواقع المراحل من الأسفل للأعلى
    // المسافة الرأسية ثابتة: 90 نقطة

    private let stagePositions: [CGPoint] = [
        CGPoint(x: 182, y: 705), // Stage 1
        CGPoint(x: 268, y: 615), // Stage 2
        CGPoint(x: 145, y: 525), // Stage 3
        CGPoint(x: 245, y: 435), // Stage 4
        CGPoint(x: 185, y: 345), // Stage 5
        CGPoint(x: 278, y: 255), // Stage 6
        CGPoint(x: 214, y: 165)  // Stage 7
    ]

    // MARK: - Main View

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in

                let scale = min(
                    geometry.size.width / designWidth,
                    geometry.size.height / designHeight
                )

                let scaledWidth = designWidth * scale
                let scaledHeight = designHeight * scale

                ZStack {

                    backgroundColor
                        .ignoresSafeArea()

                    ZStack(alignment: .topLeading) {

                        // 1. Bottom decorations
                        bottomDecorations

                        // 2. Background stars
                        starsLayer

                        // 3. Curved road
                        SmoothStageRoad(
                            points: stagePositions
                        )
                        .stroke(
                            roadColor,
                            style: StrokeStyle(
                                lineWidth: 34,
                                lineCap: .round,
                                lineJoin: .round
                            )
                        )
                        .frame(
                            width: designWidth,
                            height: designHeight
                        )

                        // 4. Stages
                        ForEach(1...7, id: \.self) { number in

                            let point = stagePositions[number - 1]

                            stage(
                                number,
                                x: point.x,
                                y: point.y
                            )
                        }

                        // 5. Unlocked stage sparkles
                        unlockedStageSparkles

                        // 6. Bottom navigation
                        bottomNavigation
                            .position(
                                x: 201,
                                y: 810
                            )
                    }
                    .frame(
                        width: designWidth,
                        height: designHeight
                    )
                    .scaleEffect(
                        scale,
                        anchor: .topLeading
                    )
                    .frame(
                        width: scaledWidth,
                        height: scaledHeight,
                        alignment: .topLeading
                    )
                }
                .frame(
                    width: geometry.size.width,
                    height: geometry.size.height
                )
            }
            .ignoresSafeArea()
            .toolbar(.hidden, for: .navigationBar)
        }

        // MARK: - Navigation Destinations

        .fullScreenCover(
            isPresented: Binding(
                get: { selectedTab == 0 },
                set: { if !$0 { selectedTab = 1 } }
            )
        ) {
            HomeView()
        }

        .fullScreenCover(
            isPresented: Binding(
                get: { selectedTab == 2 },
                set: { if !$0 { selectedTab = 1 } }
            )
        ) {
            WeeklyPerformanceView()
        }
    }

    // MARK: - Smooth Road

    private struct SmoothStageRoad: Shape {

        let points: [CGPoint]

        func path(in rect: CGRect) -> Path {

            var path = Path()

            guard let firstPoint = points.first else {
                return path
            }

            path.move(to: firstPoint)

            for index in 0..<(points.count - 1) {

                let start = points[index]
                let end = points[index + 1]

                let middleY = (start.y + end.y) / 2

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

            return path
        }
    }

    // MARK: - Stage Circles

    private func stage(
        _ number: Int,
        x: CGFloat,
        y: CGFloat
    ) -> some View {

        let unlocked = number == 1

        return ZStack {

            Ellipse()
                .fill(
                    unlocked
                    ? firstStageColor
                    : stageColor
                )

            Text("\(number)")
                .font(
                    .system(
                        size: 32,
                        weight: .medium
                    )
                )
                .foregroundStyle(
                    unlocked
                    ? stageColor
                    : .white
                )
                .offset(y: 5)

            if !unlocked {

                Image(systemName: "lock.fill")
                    .font(.system(size: 17))
                    .foregroundStyle(
                        Color.white.opacity(0.9)
                    )
                    .offset(
                        x: -25,
                        y: -22
                    )
            }
        }
        .frame(
            width: 77,
            height: 73
        )
        .position(
            x: x,
            y: y
        )
    }

    // MARK: - Unlocked Stage Sparkles

    private var unlockedStageSparkles: some View {

        ZStack(alignment: .topLeading) {

            Image(systemName: "sparkles")
                .font(
                    .system(
                        size: 34,
                        weight: .bold
                    )
                )
                .foregroundStyle(sparkleColor)
                .position(
                    x: 144,
                    y: 670
                )

            Image(systemName: "sparkles")
                .font(
                    .system(
                        size: 30,
                        weight: .bold
                    )
                )
                .foregroundStyle(sparkleColor)
                .position(
                    x: 218,
                    y: 733
                )
        }
        .frame(
            width: designWidth,
            height: designHeight
        )
    }

    // MARK: - Background Stars

    private var starsLayer: some View {

        ZStack(alignment: .topLeading) {

            star(x: 40, y: 150, size: 11, color: .blue)
            star(x: 110, y: 170, size: 8, color: .gray)
            star(x: 190, y: 95, size: 9, color: .yellow)
            star(x: 365, y: 95, size: 17, color: .yellow)
            star(x: 335, y: 70, size: 13, color: .mint)
            star(x: 320, y: 175, size: 9, color: .gray)
            star(x: 355, y: 210, size: 12, color: .pink)
            star(x: 255, y: 180, size: 13, color: .mint)

            star(x: 25, y: 295, size: 14, color: .mint)
            star(x: 370, y: 330, size: 17, color: .yellow)
            star(x: 60, y: 380, size: 10, color: .pink)
            star(x: 220, y: 325, size: 15, color: .mint)

            star(x: 45, y: 490, size: 18, color: .yellow)
            star(x: 360, y: 490, size: 11, color: .blue)

            star(x: 30, y: 590, size: 9, color: .blue)
            star(x: 55, y: 640, size: 11, color: .mint)
            star(x: 275, y: 580, size: 12, color: .yellow)

            star(x: 75, y: 765, size: 10, color: .gray)
            star(x: 360, y: 720, size: 11, color: .blue)
            star(x: 350, y: 805, size: 17, color: .yellow)
            star(x: 55, y: 820, size: 10, color: .mint)
        }
        .frame(
            width: designWidth,
            height: designHeight
        )
    }

    private func star(
        x: CGFloat,
        y: CGFloat,
        size: CGFloat,
        color: Color
    ) -> some View {

        Image(systemName: "star.fill")
            .font(.system(size: size))
            .foregroundStyle(
                color.opacity(0.75)
            )
            .position(
                x: x,
                y: y
            )
    }

    // MARK: - Bottom Decorations

    private var bottomDecorations: some View {

        ZStack(alignment: .topLeading) {

            // Left purple shape
            Ellipse()
                .fill(
                    Color(
                        red: 0.51,
                        green: 0.39,
                        blue: 0.78
                    )
                )
                .frame(
                    width: 230,
                    height: 310
                )
                .rotationEffect(.degrees(-25))
                .position(
                    x: -65,
                    y: 795
                )

            // Right blue shape
            Ellipse()
                .fill(
                    Color(
                        red: 0.23,
                        green: 0.28,
                        blue: 0.66
                    )
                )
                .frame(
                    width: 290,
                    height: 320
                )
                .rotationEffect(.degrees(30))
                .position(
                    x: 465,
                    y: 785
                )

            // Right purple shadow
            Ellipse()
                .fill(
                    Color(
                        red: 0.40,
                        green: 0.35,
                        blue: 0.76
                    )
                    .opacity(0.65)
                )
                .frame(
                    width: 225,
                    height: 165
                )
                .rotationEffect(.degrees(-20))
                .position(
                    x: 445,
                    y: 830
                )
        }
        .frame(
            width: designWidth,
            height: designHeight
        )
    }

    // MARK: - Bottom Navigation

    private var bottomNavigation: some View {

        HStack(spacing: 0) {

            // Performance
            Button {
                selectedTab = 2
            } label: {
                navigationItem(
                    icon: "chart.bar.fill",
                    title: "الأداء",
                    selected: selectedTab == 2
                )
            }

            // Stages
            Button {
                selectedTab = 1
            } label: {
                navigationItem(
                    icon: "point.topleft.down.curvedto.point.bottomright.up",
                    title: "المراحل",
                    selected: selectedTab == 1
                )
            }

            // Home
            Button {
                selectedTab = 0
            } label: {
                navigationItem(
                    icon: "house.fill",
                    title: "الرئيسية",
                    selected: selectedTab == 0
                )
            }
        }
        .buttonStyle(.plain)
        .frame(
            width: 276,
            height: 64
        )
        .background(
            Color("taskBG")
                .opacity(0.88)
        )
        .clipShape(Capsule())
    }

    private func navigationItem(
        icon: String,
        title: String,
        selected: Bool
    ) -> some View {

        VStack(spacing: 3) {

            Image(systemName: icon)
                .font(.system(size: 23))

            Text(title)
                .font(.system(size: 10))
        }
        .foregroundStyle(
            selected
            ? roadColor
            : .white
        )
        .frame(maxWidth: .infinity)
        .frame(height: 58)
        .background {

            if selected {

                Capsule()
                    .fill(
                        Color.white.opacity(0.09)
                    )
            }
        }
    }
}

#Preview {
    MapView()
}
