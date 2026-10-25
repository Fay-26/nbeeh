
import SwiftUI

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
        WindowGroup {
            NavigationStack {
                VisualAttentionGame()
            }
        }
        WindowGroup {
            NavigationStack {
                HomeView()
            }
        }
    }
}
