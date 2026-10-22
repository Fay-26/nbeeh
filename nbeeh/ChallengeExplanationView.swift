//
//  SwiftUIView.swift
//  nbeeh
//
//  Created by Fay Alabdulqader on 21/10/2026.
//

import SwiftUI

struct ChallengeExplanationView: View {
    var body: some View {
        ZStack {
            // خلفية الشاشة الأساسية
            Color("mainBG")
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Spacer()
                
                // العنوان الرئيسي
                Text("امشِ. اسمع. ركّز!")
                    .font(.system(size: 40,))
                    .foregroundColor(Color("textbig"))
                    .padding(.bottom,50)
                
                // المربع البنفسجي (Card) الذي يحتوي على التعليمات
                VStack(alignment: .trailing, spacing: 24) {
                    // النقطة الأولى
                    HStack(alignment: .top, spacing: 16) {
                        Text("امشِ عدد الخطوات المطلوب في كل مرحلة.")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(Color("textsmalldark"))
                            .multilineTextAlignment(.trailing)
                            .padding(.top,30)
                        Image(systemName: "figure.walk")
                            .font(.system(size: 25))
                            .foregroundColor(Color("textsmalldark"))
                            .frame(width: 24)
                        
                            .padding(.top,30)
                    }
                    
                    // النقطة الثانية
                    HStack(alignment: .top, spacing: 16) {
                        Text("اسمع للأصوات المستهدفة لتدريب انتباهك السمعي واستجب لها أثناء المشي.")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(Color("textsmalldark"))
                            .multilineTextAlignment(.trailing)
                        
                        Image(systemName: "ear.and.waveform")
                            .font(.system(size: 25))
                            .foregroundColor(Color("textsmalldark"))
                            .frame(width: 24)
                    }
                    
                    // النقطة الثالثة
                    HStack(alignment: .top, spacing: 16) {
                        Text("أكمل نشاط الانتباه البصري بعد إنهاء خطواتك.")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(Color("textsmalldark"))
                            .multilineTextAlignment(.trailing)
                        
                        Image(systemName: "eye")
                            .font(.system(size: 25))
                            .foregroundColor(Color("textsmalldark"))
                            .frame(width: 24)
                    }
                    
                    
                    HStack {
                        Spacer()
                        
                    }
                }
                .padding(24)
                .background(Color("box"))
                .cornerRadius(24)
                .padding(.horizontal, 40)
                
                // النص الفرعي أسفل المربع
                Text("أكمل تحديك اليومي ودَرّب انتباهك")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(Color("textsmall"))
                
                Spacer()
                
                // زر "يلا نبدأ التحدي"
                Button(action: {
                    // إجراء الزر
                }) {
                    Text("يلا نبدأ التحدي")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundColor(Color("textbig"))
                        .frame(width: 220, height: 70)
                        .padding()
                        .background(Color("botton"))
                        .cornerRadius(30)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 45)
            }
        }
    }
}

#Preview {
    ChallengeExplanationView()
}
