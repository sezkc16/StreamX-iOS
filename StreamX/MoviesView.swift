
import SwiftUI
import AVKit

struct MoviesView: View {
    @ObservedObject var manager: AddonManager

    var body: some View {
        List {
            if manager.allMovies.isEmpty {
                ContentUnavailableView(
                    "No Movies",
                    systemImage: "film",
                    description: Text(
                        "Install an add-on with a movie catalog."
                    )
                )
            } else {
                ForEach(manager.allMovies) { movie in
                    NavigationLink {
                        MoviePlayerView(movie: movie)
                    } label: {
                        Label(
                            movie.title,
                            systemImage: "film"
                        )
                    }
                }
            }
        }
        .navigationTitle("Movies")
    }
}

struct MoviePlayerView: View {
    let movie: StreamMovie

    @State private var player: AVPlayer?

    var body: some View {
        VStack(spacing: 16) {
            Text(movie.title)
                .font(.title2)
                .bold()

            if let player = player {
                VideoPlayer(player: player)
                    .frame(height: 260)
            } else {
                ProgressView("Loading video...")
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Now Playing")
        .onAppear {
            guard let url = URL(string: movie.streamUrl),
                  url.scheme?.lowercased() == "https",
                  url.host != nil else {
                return
            }

            player = AVPlayer(url: url)
            player?.play()
        }
        .onDisappear {
            player?.pause()
            player = nil
        }
    }
}
