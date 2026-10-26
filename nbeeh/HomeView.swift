//
//  SwiftUIView.swift
//  nbeeh
//
//  Created by Fay Alabdulqader on 21/10/2026.
//


import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Tab = .home

    // بيانات المستخدم
    @State private var userLevel: Int = 2
    @State private var userStreak: Int = 3
    @State private var dailySteps: Int = 1000

    var body: some View {
        ZStack(alignment: .bottom) {

            // الخلفية الأساسية
            Color("mainBG")
                .ignoresSafeArea()

            VStack(spacing: 20) {

                // Header
                HStack {
                    NavigationLink(destination: AboutAppView()) {
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

                // المستوى والستريك
                HStack(spacing: 16) {

                    // مربع المستوى
                    VStack(alignment: .trailing, spacing: 8) {
                        HStack {
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

                // النصوص التحفيزية
                VStack(spacing: 6) {
                    Text("مستعد لتحدي اليوم؟")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color("textbig"))

                    Text("خل انتباهك حاضر وخذها خطوة بخطوة.")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(Color("textsmall"))
                }

                // بطاقة تحدي اليوم
                VStack(alignment: .trailing, spacing: 20) {

                    HStack(alignment: .top) {

                        VStack(alignment: .trailing, spacing: 5) {
                            Text("\(dailySteps.formatted()) خطوة")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color("textsmalldark"))

                            Text("امشِ ودَرّب\nانتباهك")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(Color("textsmalldark"))
                                .multilineTextAlignment(.trailing)
                        }


                        Image(systemName: "figure.walk")
                            .font(.system(size: 20))
                            .foregroundColor(Color("textsmall"))
                            .padding(10)
                            .background(Color("taskBG"))
                            .cornerRadius(15)
                    }

                    // زر بدء التحدي
                    Button(action: {
                        // أضيفي الانتقال إلى شاشة التحدي هنا
                    }) {
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

                Spacer(minLength: 80)
            }

            // شريط التنقل السفلي
            CustomTabBar(selectedTab: $selectedTab)
                .padding(.bottom, 10)
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
