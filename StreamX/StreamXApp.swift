
import SwiftUI

@main
struct StreamXApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
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
                    VideoPlayerView()
                } label: {
                    Label(
                        "Play Stream",
                        systemImage: "play.fill"
                    )
                    .frame(maxWidth: .infinity)
                    .padding()
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)

                Spacer()
            }
            .navigationTitle("StreamX")
        }
    }
}
