//
//  moving pageAud.swift
//  nbeeh
//
//  Created by Njoud Altalal on 10/05/1448 AH.
//
import SwiftUI
struct movingPageAud: View {
   
    @Environment(\.dismiss) private var dismiss
    @State private var showExitConfirmation = false

           var body: some View {
               VStack(spacing: 0) {

                   // زر الخروج
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
                   }
                   .padding(.horizontal, 8)

                   // عنوان النجاح
                   VStack(spacing: 8) {
                       Text("رهييب!")
                           .font(.system(size: 72, weight: .bold))
                           .foregroundStyle(.textbig)

                       Text("خلصت خطواتك")
                           .font(.system(size: 28, weight: .regular))
                           .foregroundStyle(.textsmall)
                   }
                   .padding(.top, 40)

                   // الصورة والرقم في المنتصف
                   ZStack {
                       Image(.starsmove)
                           .resizable()
                           .scaledToFit()

                       Text("0")
                           .font(.system(size: 64, weight: .bold))
                           .foregroundStyle(.textbig)
                   }
                   .frame(width: 280, height: 280)
                   .frame(maxWidth: .infinity)
                   .padding(.top, 24)

            
                   
                   Text("وعشان تدرب تركيزك أكثر،\nكمل آخر جزء من التحدي!")
                       .font(.system(size: 24, weight: .regular))
                       .foregroundStyle(.textsmall)
                       .multilineTextAlignment(.center)
                       .padding(.horizontal, 20)
                       .padding(.top, 8)
                   
                   
                   // الزر الجديد هنا
                   Button {
                           // لوجيك بعدين
                   } label: {
                       Text("مهمة الانتباه البصري")
                           .font(.system(size: 20, weight: .semibold))
                           .foregroundStyle(.white)
                           .frame(width: 220, height: 70)
                           .background(Color.botton)
                           .clipShape(RoundedRectangle(cornerRadius: 20))
                           .padding(.top, 20)
                   }
               }
               .padding(.horizontal, 16)
               .padding(.top, 8)
               .frame(
                   maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .top
               )
               .background(Color.mainBG)
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
    movingPageAud()
}




