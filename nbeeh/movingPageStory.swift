//
//  movingPageStory.swift
//  nbeeh
//
//  Created by Njoud Altalal on 11/05/1448 AH.
//

import SwiftUI

struct movingPageStory: View {

    @Environment(\.dismiss) private var dismiss
    @State private var showExitConfirmation = false

    var body: some View {

        GeometryReader { geometry in

            VStack(spacing: 0) {

                // زر الخروج
                HStack {
                    Button {
                        showExitConfirmation = true
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 30, weight: .medium))
                            .foregroundStyle(.black)
                            .frame(width: 48, height: 48)
                            .background(Color.box, in: Circle())
                    }

                    Spacer()
                }
                .padding(.horizontal, 8)

                // عنوان النجاح
                VStack(spacing: 8) {
                    Text("رهييب!")
                        .font(.system(size: 72, weight: .bold))
                        .foregroundStyle(Color.textbig)

                    Text("خلصت خطواتك")
                        .font(.system(size: 28, weight: .regular))
                        .foregroundStyle(Color.textsmall)
                }
                .padding(.top, 12)

                // النجوم والرقم
                ZStack {
                    Image(.starsmove)
                        .resizable()
                        .scaledToFit()

                    Text("0")
                        .font(.system(size: 64, weight: .bold))
                        .foregroundStyle(Color.textbig)
                }
                .frame(
                    width: min(geometry.size.width * 0.72, 280),
                    height: min(geometry.size.width * 0.72, 280)
                )
                .frame(maxWidth: .infinity)
                .padding(.top, 24)

                // النص أسفل الصورة
                Text("الحين جاء وقت الإجابة على أسئلة القصة")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundStyle(Color.textsmall)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 8)
                    .padding(.top, 16)

                Spacer(minLength: 20)

                // زر جاهز
                Button {
                    // نضيف الانتقال إلى أسئلة القصة لاحقًا
                } label: {
                    Text("جاهز")
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 245, height: 96)
                        .background(
                            Color.botton,
                            in: RoundedRectangle(cornerRadius: 32)
                        )
                }
                .padding(.bottom, 40)
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .top
            )
            .background(Color.mainBG)
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
}

#Preview {
    movingPageStory()
}


