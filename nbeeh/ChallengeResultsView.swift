//
//  ChallengeResultsView.swift
//  nbeeh
//
//  Created by Monerah Almousa on 11/05/1448 AH.
//

import SwiftUI

struct ChallengeResultsView: View {
    
    var visualCorrectAnswers: Int = 0
    var visualTotalErrors: Int = 0
    var visualAverageReactionTime: Double = 0

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background
                Color("mainBG")
                    .ignoresSafeArea()

                VStack(spacing: 0) {

                    // Top decoration and title
                    ZStack {
                        Image("starsmove2")
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: geometry.size.width * 0.82,
                                height: geometry.size.height * 0.38
                            )

                        VStack(spacing: 12) {
                            Text("كفوو!")
                                .font(.system(size: 76, weight: .bold))
                                .foregroundStyle(Color("textbig"))

                            Text("خلصت تحدي اليوم")
                                .font(.system(size: 25))
                                .foregroundStyle(Color("textbig"))
                        }
                        .multilineTextAlignment(.center)
                    }
                    .frame(height: geometry.size.height * 0.43)
                    .padding(.top, 3)

                    Spacer(minLength: 12)

                    VStack(alignment: .trailing, spacing: 0) {

                        Text("نتائج التحدي :")
                            .font(.system(size: 33, weight: .bold))
                            .foregroundStyle(Color("mainBG"))
                            .padding(.bottom, 32)

                        Text("الإنتباه السمعي :")
                            .font(.system(size: 23))
                            .foregroundStyle(Color("mainBG"))

                        HStack(spacing: 0) {
                            resultSymbol(false)
                            resultSymbol(false)
                            resultSymbol(false)
                            resultSymbol(true)
                            resultSymbol(true)
                            resultSymbol(true)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 30)
                        .padding(.bottom, 30)

                        Text("الإنتباه البصري :")
                            .font(.system(size: 23))
                            .foregroundStyle(Color("mainBG"))

                        HStack(spacing: 0) {
                            ForEach(0..<5, id: \.self) { index in
                                resultSymbol(index < visualCorrectAnswers)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 20)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: geometry.size.height * 0.50,
                        alignment: .topTrailing
                    )
                    .background(Color("box"))
                    .clipShape(
                        RoundedRectangle(cornerRadius: 45)
                    )
                    .padding(.horizontal, 26)

                    Spacer(minLength: 25)
                }
            }
            .frame(
                width: geometry.size.width,
                height: geometry.size.height
            )
        }
        .preferredColorScheme(.dark)
    }

    private func resultSymbol(_ success: Bool) -> some View {
        Image(systemName: success ? "checkmark.circle" : "minus.circle")
            .font(.system(size: 33, weight: .medium))
            .foregroundStyle(Color("mainBG"))
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    ChallengeResultsView()
}
