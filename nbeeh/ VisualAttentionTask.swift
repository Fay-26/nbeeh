import SwiftUI

struct VisualAttentionTask: View {
    @AppStorage("forceReturnToHome")
    private var forceReturnToHome = false
    @State private var showExitConfirmation = false
    var body: some View {
        ZStack {
            Color("mainBG")
                .ignoresSafeArea()

            VStack(spacing: 0) {

                HStack {
                   
                    Button {
                        showExitConfirmation = true
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 30, weight: .semibold))
                            .foregroundStyle(.taskBG)
                            .frame(width: 48, height: 48)
                            .background(Color.box, in: Circle())
                    }
                    .buttonStyle(.plain)

                    Spacer()
                }
                .padding(.leading, 32)
                .padding(.top, 20)

                Text("فنااان!")
                    .font(.system(size: 64))
                    .foregroundStyle(Color("textbig"))
                    .padding(.top, 8)

                Text("خلصت من مهمة الإنتباه السمعي")
                    .font(.system(size: 26))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color("textsmall").opacity(0.8))
                    .padding(.top, 28)

                Spacer()

                Image("smart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 250)

                Text("وعشان تدرب تركيزك أكثر كمل اخر جزء من التحدي")
                    .font(.system(size: 23))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color("textsmall").opacity(0.8))
                    .padding(.top, 55)

                Spacer()

                NavigationLink {
                    VisualAttentionGame()
                } label: {
                    Text("مهمة الإنتباه البصري")
                        .font(.system(size: 24))
                        .foregroundStyle(Color("textbig"))
                        .frame(width: 220, height: 70)
                        .background(Color("botton"))
                        .clipShape(
                            RoundedRectangle(cornerRadius: 30)
                        )
                        .contentShape(
                            RoundedRectangle(cornerRadius: 30)
                        )
                }
                .buttonStyle(.plain)
                .padding(.bottom, 45)
            }
        }
        .preferredColorScheme(.dark)
        .alert("هل أنت متأكدة من الخروج؟", isPresented: $showExitConfirmation) {
            Button("الاستمرار", role: .cancel) {
            }

            Button("تأكيد الخروج", role: .destructive) {
                print("Exit button tapped")
                forceReturnToHome = true
            }
        } message: {
            Text("الخروج يؤدي إلى إعادة المرحلة من جديد")
        }
        .tint(Color("botton"))
    }
}

#Preview {
    VisualAttentionTask()
       }
