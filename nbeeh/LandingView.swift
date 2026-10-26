
import SwiftUI

struct LandingView: View {
    @State private var isActive: Bool = false
    @State private var opacity: Double = 1.0

    var body: some View {
        ZStack {
            Color("mainBG")
                .ignoresSafeArea()

            if isActive {
                LandingView2()
                    .transition(.opacity)
            } else {
                ZStack(alignment: .bottom) {
                    Color("mainBG")
                        .ignoresSafeArea()

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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            opacity = 0.0
                        }

                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                isActive = true
                            }
                        }
                    }
                }
            }
        }
        .environment(\.layoutDirection, .leftToRight)
    }
}

#Preview {
    LandingView()
}

