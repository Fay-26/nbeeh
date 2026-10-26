import SwiftUI

struct VisualAttentionTask: View {
<<<<<<< HEAD
    var body: some View {
        ZStack {
            Color("mainBG")
                .ignoresSafeArea()
=======

    var body: some View {
        ZStack {
            Color("mainBG")
                .ignoresSafeArea()
>>>>>>> main

            VStack(spacing: 0) {

<<<<<<< HEAD
                HStack {
                   
                    Button {
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 30, weight: .semibold))
                            .foregroundStyle(Color("mainBG"))
                            .frame(width: 48, height: 48)
                            .background(Color("box"), in: Circle())
                    }
                    .buttonStyle(.plain)
=======
                HStack {
                    Button(action: {}) {
                        Image(systemName: "xmark")
                            .font(.system(size: 30))
                            .foregroundStyle(.black)
                            .frame(width: 52, height: 52)
                            .background(Color("box"))
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
>>>>>>> main

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
    }
}

#Preview {
    VisualAttentionTask()
       }
