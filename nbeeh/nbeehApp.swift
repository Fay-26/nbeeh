
import SwiftUI

@main
struct nbeehApp: App {

    @AppStorage("hasCompletedIntroduction")
    private var hasCompletedIntroduction = false

    @AppStorage("forceReturnToHome")
    private var forceReturnToHome = false

    @State private var rootID = UUID()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if hasCompletedIntroduction {
                    HomeView()
                } else {
                    LandingView()
                }
            }
            .id(rootID)
            .onChange(of: forceReturnToHome) { _, shouldReturn in
                print("Exit requested:", shouldReturn)

                if shouldReturn {
                    hasCompletedIntroduction = true
                    rootID = UUID()
                    forceReturnToHome = false
                    print("Returning to HomeView")
                }
            }
        }
    }
}
