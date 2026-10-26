


import SwiftUI
import Combine

final class AppNavigation: ObservableObject {
    @Published var showHome = false

    func goHome() {
        showHome = true
    }
}

@main
struct nbeehApp: App {

    @AppStorage("hasCompletedIntroduction")
    private var hasCompletedIntroduction = false

    var body: some Scene {
        WindowGroup {
            if hasCompletedIntroduction {
                HomeView()
            } else {
                LandingView()
            }
        }
    }
}

