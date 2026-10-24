

import SwiftUI

@main
struct StreamXApp: App {
    @StateObject private var addonManager = AddonManager()

    var body: some Scene {
        WindowGroup {
            ContentView(manager: addonManager)
        }
    }
}

struct ContentView: View {
    @ObservedObject var manager: AddonManager

    var body: some View {
        NavigationStack {
            VStack(spacing: 22) {
                Spacer()

                Image(systemName: "play.rectangle.fill")
                    .font(.system(size: 75))
                    .foregroundStyle(.blue)

                Text("StreamX")
                    .font(.largeTitle)
                    .bold()

                Text("Your Native iOS Streaming App")
                    .foregroundStyle(.secondary)

                NavigationLink {
                    MoviesView(manager: manager)
                } label: {
                    Label(
                        "Browse Movies",
                        systemImage: "film.fill"
                    )
                    .frame(maxWidth: .infinity)
                    .padding()
                }
                .buttonStyle(.borderedProminent)

                NavigationLink {
                    VideoPlayerView()
                } label: {
                    Label(
                        "Play Stream",
                        systemImage: "play.fill"
                    )
                    .frame(maxWidth: .infinity)
                    .padding()
                }
                .buttonStyle(.bordered)

                NavigationLink {
                    AddonView(manager: manager)
                } label: {
                    Label(
                        "Manage Add-ons",
                        systemImage: "puzzlepiece.extension.fill"
                    )
                    .frame(maxWidth: .infinity)
                    .padding()
                }
                .buttonStyle(.bordered)

                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle("StreamX")
        }
    }
}
