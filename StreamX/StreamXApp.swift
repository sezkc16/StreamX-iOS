
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
            VStack(spacing: 20) {
                Image(systemName: "play.rectangle.fill")
                    .font(.system(size: 70))
                    .foregroundStyle(.blue)

                Text("Welcome to StreamX")
                    .font(.title)
                    .bold()

                Text("Your native iOS streaming app")
                    .foregroundStyle(.secondary)
            }
            .navigationTitle("StreamX")
        }
    }
}
