//
//  AudWalkTask.swift
//  nbeeh
//
//  Created by Njoud Altalal on 11/05/1448 AH.
//


//
//  AudWalkTask1.swift
//  nbeeh
//
//  Created by Njoud Altalal on 09/05/1448 AH.
//

import SwiftUI

struct  AudWalkTask: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showExitConfirmation = false
    
    var body: some View {
        VStack(spacing: 0) {

            // الهيدر
            HStack {
               
                Button {
                    // زر الاكس لما اضغطه يطلع صفحة تأكيد الخروج
                    showExitConfirmation = true
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundStyle(.taskBG)
                        .frame(width: 48, height: 48)
                        .background(Color.box, in: Circle())
                }


                Spacer()

                Text("تحدي الانتباه السمعي")
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundStyle(.mainBG)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 18)
                    .background(
                        Color.box,
                        in: RoundedRectangle(cornerRadius: 20)
                    )

                Spacer()

                Image(systemName: "ear.badge.waveform")
                    .font(.system(size: 35, weight: .semibold))
                    .foregroundStyle(.box)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 8)

          
          
            // عنوان المهمة
            VStack(spacing: 10) {

                // مهمتك: جهة اليمين
                HStack {
                    Spacer()

                    Text("مهمتك:")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.textbig)
                }

                // العنوان بالنص
                Text("انتبه لصوت العصفور")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(.textbig)
                    .frame(maxWidth: .infinity, alignment: .center)

                // التعليمات بالنص وبخط أصغر
                Text("لما تسمع صوت العصفور اضغط الزر")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.textbig)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 80)
            .padding(.horizontal, 8)
            // عداد الخطوات
            VStack(spacing: 8) {
                Text("950")
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

        
            Button {
                // بنضيف وظيفة الزر لاحقًا
            } label: {
                Text("سمعت")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(.textbig)
                    .frame(width: 220, height: 70)
                    .background(
                        Color.botton,in: RoundedRectangle(cornerRadius: 30)
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
        
        .alert("هل انت متأكد من الخروج", isPresented: $showExitConfirmation) {
            Button("الاستمرار", role: .cancel) {
            }

            Button("تأكيد الخروج", role: .destructive) {
                dismiss()
            }
        } message: {
            Text("الخروج يؤدي إلى اعادة المرحلة من جديد")
        }

    }
     
       
}

#Preview {
    AudWalkTask()
}
