//
//  AboutAppView.swift
//  nbeeh
//
//  Created by Fay Alabdulqader on 21/10/2026.
//

import SwiftUI

struct AboutAppView: View {
    var body: some View {
        ZStack {
            // خلفية الشاشة الأساسية
            Color("mainBG")
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()

                // البطاقة البنفسجية الكبيرة التي تحتوي على المعلومات
                VStack(alignment: .trailing, spacing: 20) {
                    // قسم "عن التطبيق"
                    VStack(alignment: .trailing, spacing: 10) {
                        Text("عن التطبيق")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color("textsmalldark"))
                        
                        Text("يهدف نبيه إلى مساعدة المستخدم على تحسين انتباهه وتقليل التشتت الناتج عن كثرة المشتتات الرقمية.\n\nمن خلال تدريب الانتباه الانتقائي للتركيز على عناصر محددة وتجاهل المشتتات، والانتباه المستمر للمحافظة على التركيز لفترة من الوقت.")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(Color("textsmalldark"))
                            .multilineTextAlignment(.trailing)
                            .padding(.top, 20)
                    }
                    
                    Divider()
                        .background(Color("textsmalldark").opacity(0.3))
                    
                    // قسم "كيف تستخدم التطبيق؟"
                    VStack(alignment: .trailing, spacing: 14) {
                        Text("كيف تستخدم التطبيق؟")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color("textsmalldark"))
                        
                        // النقطة الأولى
                        HStack(alignment: .top, spacing: 12) {
                            Text("امشي عدد الخطوات المطلوب في كل مرحلة.")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(Color("textsmalldark"))
                                .multilineTextAlignment(.trailing)
                                .padding(.top, 20)
                            
                            Image(systemName: "figure.walk")
                                .font(.system(size: 20))
                                .foregroundColor(Color("textsmalldark"))
                                .frame(width: 20)
                                .padding(.top, 20)
                        }
                        
                        // النقطة الثانية
                        HStack(alignment: .top, spacing: 12) {
                            Text("اسمع للأصوات المستهدفة لتدريب انتباهك السمعي واستجب لها أثناء المشي.")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(Color("textsmalldark"))
                                .multilineTextAlignment(.trailing)
                            
                            Image(systemName: "ear.and.waveform")
                                .font(.system(size: 20))
                                .foregroundColor(Color("textsmalldark"))
                                .frame(width: 20)
                        }
                        
                        // النقطة الثالثة
                        HStack(alignment: .top, spacing: 12) {
                            Text("أكمل نشاط الانتباه البصري بعد إنهاء خطواتك.")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(Color("textsmalldark"))
                                .multilineTextAlignment(.trailing)
                            
                            Image(systemName: "eye")
                                .font(.system(size: 20))
                                .foregroundColor(Color("textsmalldark"))
                                .frame(width: 20)
                                .padding(.bottom, 30)
                        }
                    }
                }
                .padding(24)
                .background(Color("box"))
                .cornerRadius(40)
                .padding(.horizontal, 40)
                
                Spacer()
                
                // زر "فهمت" بالأسفل
                Button(action: {
                    // إجراء الزر
                }) {
                    Text("فهمت")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundColor(Color("textbig"))
                        .frame(width: 220, height: 70)
                        .padding()
                        .background(Color("botton"))
                        .cornerRadius(30)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 30)
            }
        }
    }
}

#Preview {
    AboutAppView()
}
