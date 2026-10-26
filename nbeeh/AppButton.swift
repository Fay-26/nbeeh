//
//  AppButton.swift
//  nbeeh
//
//  Created by Linah on 15/05/1448 AH.
//
import SwiftUI

struct AppButton: View {
    let onConfirmExit: () -> Void

    @State private var showExitAlert = false

    var body: some View {
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
        .buttonStyle(.plain)
        .alert(
            "هل أنت متأكد من الخروج؟",
            isPresented: $showExitAlert
        ) {
            Button("تأكيد الخروج", role: .destructive) {
                onConfirmExit()
            }

            Button("الاستمرار", role: .cancel) {}
        } message: {
            Text("الخروج يؤدي إلى إعادة المرحلة من جديد.")
        }
    }
}
