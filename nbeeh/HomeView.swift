//
//  SwiftUIView.swift
//  nbeeh
//
//  Created by Fay Alabdulqader on 21/10/2026.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Tab = .home
    
    // متغيرات بيانات المستخدم الديناميكية
    @State private var userLevel: Int = 2          // المستوى الحالي
    @State private var userStreak: Int = 3         // الستريك الحالي (الأيام)
    @State private var dailySteps: Int = 1000      // عدد خطوات تحدي اليوم
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // خلفية الشاشة الأساسية
            Color("mainBG")
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // شريط العلوية (Header)
                HStack {
                    Button(action: {}) {
                        Image(systemName: "questionmark")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color("textsmalldark"))
                            .frame(width: 32, height: 32)
                            .background(Color("box"))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Text("خلك نبيه!")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(Color("textbig"))
                }
                .padding(.horizontal, 24)
                .padding(.top, 10)
                
                // المربعات العلوية (المستوى والستريك المتغيران)
                HStack(spacing: 16) {
                    // مربع المستوى
                    VStack(alignment: .trailing, spacing: 8) {
                        HStack {
                            // عرض المستوى ديناميكياً
                            Text("المستوى \(userLevel)")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(Color("textsmalldark"))
                            Image(systemName: "chart.bar.fill")
                                .foregroundColor(Color("textsmalldark"))
                        }
                        Text("مستواك الحالي")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color("textsmalldark"))
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(16)
                    .background(Color("box"))
                    .cornerRadius(30)
                    
                    // مربع الستريك
                    VStack(alignment: .trailing, spacing: 8) {
                        HStack {
                            // عرض عدد أيام الستريك ديناميكياً
                            Text("\(userStreak) أيام")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(Color("textsmalldark"))
                            Image(systemName: "flame.fill")
                                .foregroundColor(Color("textsmalldark"))
                        }
                        Text("الستريك الحالي")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color("textsmalldark"))
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(16)
                    .background(Color("box"))
                    .cornerRadius(30)
                }
                .padding(.horizontal, 24)
                
                // صورة الشخصية
                Image("run")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .padding(.top, 70)
                
                // نصوص التحفيز
                VStack(spacing: 6) {
                    Text("مستعد لتحدي اليوم ؟")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color("textbig"))
                    
                    Text("خل انتباهك حاضر وخذها خطوة بخطوة.")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(Color("textsmall"))
                }
                
                // بطاقة تحدي اليوم (عدد الخطوات الديناميكي)
                VStack(alignment: .trailing, spacing: 20) {
                    HStack(alignment: .top) {
                        VStack(alignment: .trailing, spacing: 5) {
                            // عرض الخطوات ديناميكياً مع تنسيق الرقم (مثل 1,200)
                            Text("\(dailySteps.formatted()) خطوة")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color("textsmalldark"))
                            
                            Text("امشِ ودَرّب\nانتباهك")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(Color("textsmalldark"))
                                .multilineTextAlignment(.trailing)
                        }
                        
                        
                        VStack(alignment: .trailing, spacing: 4) {
                            Image(systemName: "figure.walk")
                                .font(.system(size: 20))
                                .foregroundColor(Color("textsmall"))
                                .padding(10)
                                .background(Color("taskBG"))
                                .cornerRadius(15)
                        }
                    }
                    
                    Button(action: {}) {
                        Text("ابدأ التحدي")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color("textbig"))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 25)
                            .background(Color("botton"))
                            .cornerRadius(30)
                    }
                }
                .padding(20)
                .background(Color("box"))
                .cornerRadius(50)
                .padding(.horizontal, 35)
                
                Spacer()
            }
            
            // استدعاء شريط التنقل المنفصل هنا في الأسفل
            CustomTabBar(selectedTab: $selectedTab)
                .padding(.bottom, 10)
        }
    }
}

#Preview {
    HomeView()
}
