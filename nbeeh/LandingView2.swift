//
//  LandingView2.swift
//  nbeeh
//
//  Created by Fay Alabdulqader on 21/10/2026.
//

import SwiftUI

struct LandingView2: View {

        var body: some View {
            ZStack {
                // خلفية الشاشة الأساسية
                Color("mainBG")
                    .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    Spacer()
                    
                    // النص الرئيسي بالعنوان
                    Text("دَرّب تركيزك، خطوة\nبخطوة!")
                        .font(.system(size: 36, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("textbig"))
                        .padding(.bottom, 40)
                    
                    // صورة الشخصية وهي تركض
                    Image("run2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220, height: 220)
                    
                 
                        .padding(.bottom, 80)
                    
                    // الأزرار
                    VStack(spacing: 16) {
                        // زر "فهمني أكثر"
                        Button(action: {
                            // إجراء الزر
                        }) {
                            Text("فهمني أكثر")
                                .font(.system(size: 28, weight: .semibold))
                                .foregroundColor(Color("textbig"))
                                .frame(width: 220, height: 70)
                                .padding()
                                .background(Color("botton"))
                                .cornerRadius(30)
                                .padding(.bottom, 20)
                        }
                        
                        // زر "ابدأ التحدي"
                        Button(action: {
                            // إجراء الزر
                        }) {
                            Text("ابدأ التحدي")
                                .font(.system(size: 24, weight: .medium))
                                .foregroundColor(Color("textsmall"))
                    
                        }
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, 45)
                }
            }
        }
    }

#Preview {
    LandingView2()
}
