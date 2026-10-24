//
//  QuizView.swift
//  nbeeh
//
//  Created by Linah on 11/05/1448 AH.
//
import SwiftUI

// MARK: - نموذج السؤال
struct QuizQuestion {
    let question: String
    let options: [String]
    let correctAnswer: Int
}

struct QuizView: View {

    
    private let backgroundColor = Color("taskBG")
    private let questionColor = Color("box")
    private let buttonColor = Color("botton")
    private let questionTextColor = Color("textsmalldark")
    private let answerTextColor = Color("textbig")
    private let borderColor = Color("box")

    @Environment(\.dismiss) private var dismiss

    private let questions: [QuizQuestion] = [
        QuizQuestion(
            question: "ايش اسم الشخصية الرئيسية بالقصة؟",
            options: ["سعود", "خالد", "محمد"],
            correctAnswer: 0
        ),
        QuizQuestion(
            question: "وش الأشياء الشخصية اللي كان شايلها معه؟",
            options: [
                "قلم، دفتر، ساندوتش",
                "جوال، سماعات، مفاتيح",
                "علك، محفظة، نظارة"
            ],
            correctAnswer: 1
        ),
        QuizQuestion(
            question: "كيف راح سعود للجامعة؟",
            options: ["بالباص", "بالمترو", "بالسيارة"],
            correctAnswer: 2
        ),
        QuizQuestion(
            question: "تأخر سعود على أي كلاس؟",
            options: ["أناتومي", "ماث", "إنجليزي"],
            correctAnswer: 1
        ),
        QuizQuestion(
            question: "سبب تأخير سعود عن الكلاس؟",
            options: [
                "زحمة المرور",
                "قابل صديقه في الطريق",
                "سقطت أغراضه"
            ],
            correctAnswer: 0
        )
    ]

    @State private var currentQuestionIndex = 0
    @State private var correctAnswers = 0
    @State private var wrongAnswers = 0
    @State private var selectedAnswer: Int? = nil
    @State private var hasAnswered = false

    @State private var showExitAlert = false
    @State private var showCompletionMessage = false

    private var currentQuestion: QuizQuestion {
        questions[currentQuestionIndex]
    }

    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()

            VStack(spacing: 0) {
                headerView

                progressView

                questionView

                Spacer(minLength: 35)

                answersView

                Spacer(minLength: 35)
            }
            .padding(.horizontal, 28)
            .padding(.top, 12)
            .padding(.bottom, 20)
            .environment(\.layoutDirection, .rightToLeft)
        }

        .alert(
            "هل أنت متأكد من الخروج؟",
            isPresented: $showExitAlert
        ) {
            Button("تأكيد الخروج", role: .destructive) {
                dismiss()
            }

            Button("الاستمرار", role: .cancel) {
            }
        } message: {
            Text("الخروج يؤدي إلى إعادة المرحلة من جديد.")
        }

        .alert(
            "خلصتي التحدي!",
            isPresented: $showCompletionMessage
        ) {
            Button("إعادة التحدي") {
                resetQuiz()
            }

            Button("إنهاء", role: .cancel) {
            }
        } message: {
            Text(
                "الإجابات الصحيحة: \(correctAnswers)\n" +
                "الإجابات الخاطئة: \(wrongAnswers)"
            )
        }
    }

    private var headerView: some View {
        HStack(spacing: 12) {

            
            Button {
                showExitAlert = true
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.black)
                    .frame(width: 44, height: 44)
                    .background(
                        Color(
                            red: 194.0 / 255.0,
                            green: 169.0 / 255.0,
                            blue: 201.0 / 255.0
                        )
                    )
                    .clipShape(Circle())
            }

            Spacer(minLength: 0)

            
            Text("تحدي الانتباه السمعي")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(questionTextColor)
                .padding(.horizontal, 13)
                .padding(.vertical, 10)
                .background(questionColor)
                .clipShape(RoundedRectangle(cornerRadius: 14))

            Spacer(minLength: 0)

           
            Image(systemName: "ear")
                .font(.system(size: 25))
                .foregroundStyle(questionColor)
        }


        .environment(\.layoutDirection, .leftToRight)
    }


    private var progressView: some View {
        HStack {
            Text("السؤال \(currentQuestionIndex + 1) من \(questions.count)")
                .font(.system(size: 13))
                .foregroundStyle(questionTextColor.opacity(0.8))

            Spacer()

            Text("✓ \(correctAnswers)   ✕ \(wrongAnswers)")
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(questionTextColor)
        }
        .padding(.top, 28)
    }


    private var questionView: some View {
        Text(currentQuestion.question)
            .font(.system(size: 19, weight: .medium))
            .foregroundStyle(questionTextColor)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .frame(minHeight: 135)
            .padding(.horizontal, 16)
            .background(questionColor)
            .clipShape(RoundedRectangle(cornerRadius: 32))
            .padding(.top, 34)
    }

    private var answersView: some View {
        VStack(spacing: 24) {
            ForEach(
                currentQuestion.options.indices,
                id: \.self
            ) { index in

                Button {
                    selectAnswer(index)
                } label: {
                    Text(currentQuestion.options[index])
                        .font(.system(size: 16))
                        .foregroundStyle(answerTextColor)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(
                            selectedAnswer == index
                            ? buttonColor
                            : Color.clear
                        )
                        .clipShape(Capsule())
                        .overlay {
                            Capsule()
                                .stroke(
                                    borderColor,
                                    lineWidth: 0.8
                                )
                        }
                }
                .disabled(hasAnswered)
            }
        }
        .padding(.horizontal, 2)
    }


    private func selectAnswer(_ index: Int) {
        guard !hasAnswered else { return }

        hasAnswered = true
        selectedAnswer = index

        if index == currentQuestion.correctAnswer {
            correctAnswers += 1
        } else {
            wrongAnswers += 1
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            if currentQuestionIndex < questions.count - 1 {
                currentQuestionIndex += 1
                selectedAnswer = nil
                hasAnswered = false
            } else {
                showCompletionMessage = true
            }
        }
    }

    private func resetQuiz() {
        currentQuestionIndex = 0
        correctAnswers = 0
        wrongAnswers = 0
        selectedAnswer = nil
        hasAnswered = false
    }
}

#Preview {
    QuizView()
}
