//
//  WeeklyPerformanceView 2.swift
//  nbeeh
//
//  Created by Jumanah on 15/05/1448 AH.
//


import SwiftUI

struct WeeklyPerformanceView 2: View {

    // MARK: - Tab Selection

    @State private var selectedTab: Int = 1

    // MARK: - Colors

    private let backgroundColor = Color("mainBG")
    private let cardColor = Color("taskBG")
    private let lightPurple = Color("box")
    private let purple = Color("botton")
    private let primaryText = Color("textbig")
    private let secondaryText = Color("textsmall")
    private let darkText = Color("textsmalldark")

    // MARK: - Data

    private let weeklyData: [(day: String, accuracy: Double?)] = [
        ("الأحد", 65),
        ("الاثنين", 60),
        ("الثلاثاء", 55),
        ("الأربعاء", 63),
        ("الخميس", 58),
        ("الجمعة", nil),
        ("السبت", nil)
    ]

    private let completedDays = [
        true, true, true, true, true, false, false
    ]

    private let steps = 3000
    private let weeklyAccuracy = 60

    private var completedCount: Int {
        completedDays.filter { $0 }.count
    }

    // MARK: - Main View

    var body: some View {

        GeometryReader { geometry in

            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height

            let contentWidth = min(332, screenWidth - 48)
            let verticalScale = min(1, screenHeight / 780)

            ZStack(alignment: .bottom) {

                backgroundColor
                    .ignoresSafeArea()

                VStack(spacing: 0) {

                    stepsCard
                        .frame(
                            maxWidth: .infinity,
                            alignment: .trailing
                        )
                        .padding(.top, 28)

                    performanceTitle
                        .padding(.top, 64 * verticalScale)

                    weeklyChart
                        .padding(.top, 24 * verticalScale)

                    completedChallengesCard
                        .padding(.top, 44 * verticalScale)

                    attentionAccuracyCard
                        .padding(.top, 28 * verticalScale)

                    Spacer(minLength: 8)
                }
                .frame(width: contentWidth)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .top
                )

                // MARK: - Custom Tab Bar

                CustomTabBar(selectedTab: $selectedTab)
                    .padding(.bottom, 10)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    // MARK: - Steps Card

    private var stepsCard: some View {

        HStack(spacing: 12) {

            Spacer(minLength: 0)

            VStack(alignment: .trailing, spacing: 0) {

                Text("\(steps)")
                    .font(.system(size: 24, weight: .bold))

                Text("خطواتك")
                    .font(.system(size: 11, weight: .semibold))
            }
            .foregroundStyle(primaryText)

            Image(systemName: "shoeprints.fill")
                .font(.system(size: 20))
                .foregroundStyle(primaryText)
                .frame(width: 48, height: 48)
                .overlay {
                    Circle()
                        .stroke(purple, lineWidth: 3)
                }
        }
        .padding(.leading, 4)
        .padding(.trailing, 0)
        .frame(width: 220, height: 48)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(cardColor)
                .stroke(
                    lightPurple.opacity(0.4),
                    lineWidth: 1
                )
        }
    }

    // MARK: - Title

    private var performanceTitle: some View {

        HStack(alignment: .top, spacing: 4) {

            Text("أدائك هذا الأسبوع")
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(primaryText)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Weekly Chart

    private var weeklyChart: some View {

        VStack(spacing: 8) {

            GeometryReader { chartGeometry in

                HStack(alignment: .bottom, spacing: 8) {

                    ForEach(
                        Array(weeklyData.enumerated()),
                        id: \.offset
                    ) { _, item in

                        VStack(spacing: 0) {

                            Spacer(minLength: 0)

                            ZStack(alignment: .top) {

                                Rectangle()
                                    .fill(purple)

                                if let accuracy = item.accuracy {

                                    Text("\(Int(accuracy))%")
                                        .font(.system(
                                            size: 10,
                                            weight: .semibold
                                        ))
                                        .foregroundStyle(primaryText)
                                        .padding(.top, 4)
                                }
                            }
                            .frame(
                                height: item.accuracy == nil
                                ? 4
                                : chartGeometry.size.height *
                                  CGFloat(item.accuracy ?? 0) / 100
                            )
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .environment(
                    \.layoutDirection,
                    .rightToLeft
                )
            }
            .frame(height: 184)
            .padding(.horizontal, 12)
            .padding(.top, 16)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(lightPurple)
            }
            .clipShape(
                RoundedRectangle(cornerRadius: 20)
            )

            HStack(spacing: 8) {

                ForEach(
                    Array(weeklyData.enumerated()),
                    id: \.offset
                ) { _, item in

                    Text(item.day)
                        .font(.system(size: 9))
                        .foregroundStyle(primaryText)
                        .lineLimit(1)
                        .minimumScaleFactor(0.65)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal, 12)
            .environment(
                \.layoutDirection,
                .rightToLeft
            )
        }
        .frame(width: 332)
    }

    // MARK: - Completed Challenges

    private var completedChallengesCard: some View {

        VStack(spacing: 8) {

            HStack {

                Text("\(completedCount)/7")
                    .font(.system(size: 15, weight: .bold))

                Spacer()

                Text("التحديات المكتملة")
                    .font(.system(size: 16, weight: .bold))
            }
            .foregroundStyle(primaryText)

            HStack(spacing: 4) {

                ForEach(
                    Array(completedDays.enumerated()),
                    id: \.offset
                ) { _, completed in

                    Image(
                        systemName: completed
                        ? "checkmark"
                        : "xmark"
                    )
                    .font(.system(size: 14))
                    .foregroundStyle(darkText)
                    .frame(maxWidth: .infinity)
                    .frame(height: 24)
                    .background {
                        Capsule()
                            .fill(lightPurple)
                    }
                }
            }
            .environment(
                \.layoutDirection,
                .rightToLeft
            )

            HStack {

                Spacer()

                Text("\(completedCount) أيام من أصل 7")
                    .font(.system(size: 10))
                    .foregroundStyle(primaryText)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .frame(width: 332, height: 96)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(cardColor)
                .stroke(primaryText, lineWidth: 1)
        }
    }

    // MARK: - Attention Accuracy

    private var attentionAccuracyCard: some View {

        HStack(spacing: 8) {

            Spacer(minLength: 0)

            VStack(alignment: .trailing, spacing: 4) {

                Text("دقة الانتباه")
                    .font(.system(size: 16, weight: .bold))

                Text("نسبة الاستجابات الصحيحة أثناء التحديات")
                    .font(.system(size: 10))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)

                Text("متوسط هذا الأسبوع")
                    .font(.system(size: 10))
            }
            .foregroundStyle(primaryText)

            ZStack {

                Circle()
                    .stroke(
                        lightPurple.opacity(0.5),
                        lineWidth: 6
                    )

                Circle()
                    .trim(
                        from: 0,
                        to: CGFloat(weeklyAccuracy) / 100
                    )
                    .stroke(
                        purple,
                        style: StrokeStyle(
                            lineWidth: 6,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))

                Text("\(weeklyAccuracy)%")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(primaryText)
            }
            .frame(width: 64, height: 64)
        }
        .padding(.horizontal, 12)
        .frame(width: 332, height: 96)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(cardColor)
                .stroke(primaryText, lineWidth: 1)
        }
    }
}

// MARK: - Preview

#Preview {
    WeeklyPerformanceView 2 ()
}
