//
//  QuizView.swift
//  nbeeh
//
//  Created by Linah on 11/05/1448 AH.
//
 import SwiftUI

// MARK: - نموذج السؤال
// هذا النوع يخزن نص السؤال والخيارات ورقم الإجابة الصحيحة.
struct QuizQuestion {
    let question: String
    let options: [String]
    let correctAnswer: Int
}
