//
//  AudWalkStory.swift
//  nbeeh
//
//  Created by Njoud Altalal on 11/05/1448 AH.
//

import SwiftUI

struct AudWalkStory: View {

    @Environment(\.dismiss) private var dismiss
    @State private var showExitConfirmation = false
    @State private var isPlaying = false

    var body: some View {
        VStack(spacing: 0) {

            // الهيدر
            HStack {
                Button {
                    showExitConfirmation = true
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundStyle(.taskBG)
                        .frame(width: 48, height: 48)
                        .background(Color.box, in: Circle())
                }

                Spacer()

                Text("التحدي الانتباه السمعي")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.mainBG)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(
                        Color.box,
                        in: RoundedRectangle(cornerRadius: 12)
                    )

                Spacer()

                Image(systemName: "ear.badge.waveform")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundStyle(.box)
            }
            .padding(.horizontal, 8)

            // عنوان المهمة والتعليمات
            VStack(spacing: 10) {
                HStack {
                    Spacer()

                    Text("مهمتك:")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.textbig)
                }

                Text("ركز بتفاصيل القصة المسموعة")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(.textbig)
                    .frame(maxWidth: .infinity)

                Text(
                    isPlaying
                    ? "راح تجاوب على اسئلة بعد القصة"
                    : "اضغط زر التشغيل للاستماع إلى القصة"
                )
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(.textbig)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
            }
            .padding(.top, 80)
            .padding(.horizontal, 8)

            // عداد الخطوات
            VStack(spacing: 8) {
                Text("743")
                    .font(.system(size: 72, weight: .bold))
                    .foregroundStyle(.mainBG)

                Text("العد التنازلي لخطواتك")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.mainBG)
            }
            .frame(width: 277, height: 209)
            .overlay(alignment: .topTrailing) {
                Image(systemName: "arrowshape.down")
                    .font(.system(size: 40, weight: .medium))
                    .foregroundStyle(.mainBG)
                    .padding(16)
            }
            .background(
                Color.box,
                in: RoundedRectangle(cornerRadius: 30)
            )
            .padding(.top, 48)
            .frame(maxWidth: .infinity)

            // زر التشغيل والموجات الصوتية
            Button {
                withAnimation(.easeInOut(duration: 0.25)) {
                    isPlaying.toggle()
                }
            } label: {
                Image(
                    systemName: isPlaying
                    ? "waveform"
                    : "play"
                )
                .font(.system(size: 26, weight: .medium))
                .foregroundStyle(.mainBG)
                .frame(width: 220, height: 70)
                .background(
                    Color.botton,
                    in: RoundedRectangle(cornerRadius: 20)
                )
            }
            .padding(.top, 56)
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        )
        .background(Color.taskBG)
        .alert(
            "هل أنت متأكد من الخروج؟",
            isPresented: $showExitConfirmation
        ) {
            Button("الاستمرار", role: .cancel) { }

            Button("تأكيد الخروج", role: .destructive) {
                dismiss()
            }
        } message: {
            Text("الخروج يؤدي إلى إعادة المرحلة من جديد")
        }
    }
}

#Preview {
    AudWalkStory()
}

