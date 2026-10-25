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

// MARK: - نموذج القصة
struct QuizStory {
    let questions: [QuizQuestion]
}

// MARK: - نتائج الاختبار
struct ChallengeResult {
    let correctAnswers: Int
    let wrongAnswers: Int
}

struct QuizView: View {

    // MARK: - الألوان
    private let backgroundColor = Color("taskBG")
    private let questionColor = Color("box")
    private let buttonColor = Color("botton")
    private let questionTextColor = Color("textsmalldark")
    private let answerTextColor = Color("textbig")
    private let borderColor = Color("box")

    @Environment(\.dismiss) private var dismiss

    // MARK: - القصة الأولى
    private let storyOne = QuizStory(questions: [
        QuizQuestion(
            question: "متى بدت الأحداث؟",
            options: ["1:30 الليل", "2:30 الليل", "1:00 الليل"],
            correctAnswer: 1
        ),
        QuizQuestion(
            question: "إيش الصوت اللي سمعه خالد؟",
            options: ["ذيب", "تخديش", "طق"],
            correctAnswer: 1
        ),
        QuizQuestion(
            question: "مين هو الشخص اللي أرسل رسالة لخالد ووين؟",
            options: [
                "سلطان أرسل في سناب",
                "سلطان أرسل في واتساب",
                "سلطان أرسل في تيك توك"
            ],
            correctAnswer: 1
        ),
        QuizQuestion(
            question: "إيش راحوا يجيبون سلطان وفهد من السيارة؟",
            options: ["كشاف", "حطب", "ماء"],
            correctAnswer: 1
        ),
        QuizQuestion(
            question: "وين كشتوا الشباب؟",
            options: ["التنهات", "روضة خريم", "صد صلبوخ"],
            correctAnswer: 1
        )
    ])

    // MARK: - القصة الثانية
    private let storyTwo = QuizStory(questions: [
        QuizQuestion(
            question: "كم كانت الساعة لما رجع سعود من المطار؟",
            options: [
                "11:45 بالليل",
                "12:20 بعد منتصف الليل",
                "1:15 بعد منتصف الليل"
            ],
            correctAnswer: 1
        ),
        QuizQuestion(
            question: "وش كان لون جاكيت الراكب؟",
            options: ["رمادي", "أسود", "بني"],
            correctAnswer: 0
        ),
        QuizQuestion(
            question: "وش طلب الراكب من البقالة؟",
            options: [
                "موية عادية وشوكولاتة",
                "قهوة باردة وعلك",
                "موية غازية وعلبة علك نعناع"
            ],
            correctAnswer: 2
        ),
        QuizQuestion(
            question: "وش لون الظرف اللي تركه الراكب؟",
            options: ["أبيض", "أصفر", "أزرق"],
            correctAnswer: 1
        ),
        QuizQuestion(
            question: "وين لقى سعود جوال فهد؟",
            options: [
                "تحت المقعد الخلفي",
                "داخل الظرف",
                "عند باب الفندق"
            ],
            correctAnswer: 0
        )
    ])

    // MARK: - حالة الاختبار
    @State private var selectedStory: QuizStory?
    @State private var currentQuestionIndex = 0
    @State private var correctAnswers = 0
    @State private var wrongAnswers = 0
    @State private var selectedAnswer: Int? = nil
    @State private var hasAnswered = false
    @State private var showExitAlert = false
    @State private var goToVisualTask = false

    private var questions: [QuizQuestion] {
        selectedStory?.questions ?? []
    }

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
        .onAppear {
            if selectedStory == nil {
                selectedStory = Bool.random() ? storyOne : storyTwo
            }
        }
        .navigationDestination(isPresented: $goToVisualTask) {
            VisualAttentionTask()
        }
        .alert(
            "هل أنت متأكد من الخروج؟",
            isPresented: $showExitAlert
        ) {
            Button("تأكيد الخروج", role: .destructive) {
                dismiss()
            }

            Button("الاستمرار", role: .cancel) {}
        } message: {
            Text("الخروج يؤدي إلى إعادة المرحلة من جديد.")
        }
    }

    // MARK: - رأس الصفحة
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

    // MARK: - التقدم
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

    // MARK: - السؤال
    private var questionView: some View {
        Text(
            questions.indices.contains(currentQuestionIndex)
                ? currentQuestion.question
                : ""
        )
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

    // MARK: - الخيارات
    private var answersView: some View {
        VStack(spacing: 24) {
            if questions.indices.contains(currentQuestionIndex) {
                ForEach(currentQuestion.options.indices, id: \.self) { index in
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
                                    .stroke(borderColor, lineWidth: 0.8)
                            }
                    }
                    .disabled(hasAnswered)
                }
            }
        }
        .padding(.horizontal, 2)
    }

    // MARK: - اختيار الإجابة
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
                goToVisualTask = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        QuizView()
    }
}
