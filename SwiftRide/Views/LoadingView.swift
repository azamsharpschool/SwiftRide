import SwiftUI

struct LoadingView: View {
    var message: String = "Loading..."

    var body: some View {
        ZStack {
            // Dark overlay background
            Color.black.opacity(0.5)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.orange))
                    .scaleEffect(1.5)

                Text(message)
                    .foregroundColor(.white)
                    .font(.headline)
                    .multilineTextAlignment(.center)
            }
            .padding(24)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange.opacity(0.9), Color.red.opacity(0.9)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(20)
            .shadow(color: Color.orange.opacity(0.4), radius: 10, x: 0, y: 5)
        }
    }
}
