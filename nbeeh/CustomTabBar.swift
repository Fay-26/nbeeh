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

            // Performance
            NavigationLink {
                WeeklyPerformanceView()
            } label: {
                tabItem(
                    title: "الأداء",
                    icon: "chart.bar.fill",
                    tab: .performance
                )
            }
            .buttonStyle(.plain)

            Spacer()

            // Stages
            NavigationLink {
                MapView()
            } label: {
                tabItem(
                    title: "المراحل",
                    icon: "point.topleft.down.curvedto.point.bottomright.up",
                    tab: .levels
                )
            }
            .buttonStyle(.plain)

            Spacer()

            // Home
            NavigationLink {
                HomeView()
            } label: {
                tabItem(
                    title: "الرئيسية",
                    icon: "house.fill",
                    tab: .home
                )
            }
            .buttonStyle(.plain)

            Spacer()
        }
        .padding(.vertical, 14)
        .background(Color("taskBG"))
        .cornerRadius(30)
        .padding(.horizontal, 24)
    }

    private func tabItem(
        title: String,
        icon: String,
        tab: Tab
    ) -> some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 20))

            Text(title)
                .font(.system(size: 11))
        }
        .foregroundColor(
            selectedTab == tab
            ? Color("textbig")
            : Color("textsmall")
        )
    }
}

#Preview {
    NavigationStack {
        CustomTabBar(selectedTab: .constant(.home))
    }
}
