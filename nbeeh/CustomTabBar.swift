//
//  SwiftUIView.swift
//  nbeeh
//
//  Created by Fay Alabdulqader on 21/10/2026.
//

import SwiftUI

enum Tab {
    case performance, levels, home
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack {
            Spacer()
            
            // زر الأداء
            Button(action: { selectedTab = .performance }) {
                VStack(spacing: 4) {
                    Image(systemName: "chart.bar.fill")
                        .font(.system(size: 20))
                    Text("الاداء")
                        .font(.system(size: 11))
                }
                .foregroundColor(selectedTab == .performance ? Color("textbig") : Color("textsmall"))
            }
            
            Spacer()
            
            // زر المراحل
            Button(action: { selectedTab = .levels }) {
                VStack(spacing: 4) {
                    Image(systemName: "flag.fill")
                        .font(.system(size: 20))
                    Text("المراحل")
                        .font(.system(size: 11))
                }
                .foregroundColor(selectedTab == .levels ? Color("textbig") : Color("textsmall"))
            }
            
            Spacer()
            
            // زر الرئيسية
            Button(action: { selectedTab = .home }) {
                VStack(spacing: 4) {
                    Image(systemName: "house.fill")
                        .font(.system(size: 20))
                    Text("الرئيسية")
                        .font(.system(size: 11))
                }
                .foregroundColor(selectedTab == .home ? Color("textbig") : Color("textsmall"))
            }
            
            Spacer()
        }
        .padding(.vertical, 14)
        .background(Color("taskBG"))
        .cornerRadius(30)
        .padding(.horizontal, 24)
    }
}
