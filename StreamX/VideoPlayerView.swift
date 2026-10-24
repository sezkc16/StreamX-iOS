
import SwiftUI
import AVKit

struct VideoPlayerView: View {
    @State private var videoURL = ""
    @State private var player: AVPlayer?
    @State private var showError = false

    var body: some View {
        VStack(spacing: 20) {
            Text("StreamX Player")
                .font(.title2)
                .bold()

            TextField(
                "Enter HTTPS MP4 or M3U8 URL",
                text: $videoURL
            )
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .keyboardType(.URL)
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal)

            Button("Play Stream") {
                guard let url = URL(string: videoURL),
                      url.scheme?.lowercased() == "https",
                      url.host != nil else {
                    showError = true
                    return
                }

                player?.pause()
                player = AVPlayer(url: url)
                player?.play()
            }
            .buttonStyle(.borderedProminent)

            if let player = player {
                VideoPlayer(player: player)
                    .frame(height: 250)
            }

            Spacer()
        }
        .padding(.top)
        .alert("Invalid URL", isPresented: $showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Enter a valid HTTPS video URL.")
        }
        .onDisappear {
            player?.pause()
        }
    }
}
