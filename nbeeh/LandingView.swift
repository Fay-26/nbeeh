//
//  ContentView.swift
//  nbeeh
//
//  Created by Fay Alabdulqader on 20/10/2026.
//

import SwiftUI

struct LandingView: View {
    @State private var isActive: Bool = false
    @State private var opacity: Double = 1.0
    
    var body: some View {
        ZStack {
            // تثبيت لون الخلفية الأساسي على مستوى الـ ZStack الخارجي لضمان عدم ظهور لون أبيض أبداً
            Color("mainBG")
                .ignoresSafeArea()
            
            if isActive {
                // الانتقال إلى LandingView2 بعد انتهاء التلاشي
                LandingView2()
                    .transition(.opacity)
            } else {
                ZStack(alignment: .bottom) {
                    Color("mainBG")
                        .ignoresSafeArea(edges: .bottom)
                        .ignoresSafeArea(edges: .top)
                    
                    VStack {
                        Spacer()
                        
                        ZStack {
                            Image("stars")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .offset(x: 120, y: -80)
                            
                            Image("stars2")
                                .resizable()
                                .frame(width: 28, height: 28)
                                .offset(x: 140, y: 10)
                            
                            Image("stars3")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .offset(x: -120, y: -30)
                            
                            Image("stars")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .offset(x: -100, y: 50)
                            
                            VStack(spacing: 8) {
                                Text("اهلا بك في")
                                    .font(.system(size: 38, weight: .medium))
                                    .foregroundColor(Color("textbig"))
                                
                                Text("نبيه")
                                    .font(.system(size: 64, weight: .bold))
                                    .foregroundColor(Color("textbig"))
                            }
                        }
                        
                        Spacer()
                        Spacer()
                    }
                    .padding()
                    
                    HStack {
                        Image("greet")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 400)
                            .offset(x: 10, y: 10)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .ignoresSafeArea(edges: .bottom)
                }
                .opacity(opacity)
                .onAppear {
                    // الانتظار لمدة 5 ثوانٍ كاملة قبل بدء التلاشي
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            opacity = 0.0 // تأثير التلاشي التدريجي
                        }
                        
                    }
                }
            }
        }
        .environment(\.layoutDirection, .rightToLeft)
    }
}

#Preview {
    LandingView()
}
