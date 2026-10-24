


import SwiftUI

@main
struct StreamXApp: App {
    @StateObject private var addonManager = AddonManager()

    var body: some Scene {
        WindowGroup {
            MainTabView(manager: addonManager)
                .preferredColorScheme(.dark)
        }
    }
}

struct MainTabView: View {
    @ObservedObject var manager: AddonManager

    var body: some View {
        TabView {
            NavigationStack {
                HomeView(manager: manager)
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }

            NavigationStack {
                SearchView(manager: manager)
            }
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }

            NavigationStack {
                MoviesView(manager: manager)
            }
            .tabItem {
                Label("Library", systemImage: "film.fill")
            }

            NavigationStack {
                AddonView(manager: manager)
            }
            .tabItem {
                Label(
                    "Add-ons",
                    systemImage: "puzzlepiece.extension.fill"
                )
            }
        }
        .tint(.red)
    }
}

struct SearchView: View {
    @ObservedObject var manager: AddonManager
    @State private var searchText = ""

    var filteredMovies: [StreamMovie] {
        guard !searchText.isEmpty else {
            return manager.allMovies
        }

        return manager.allMovies.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        List(filteredMovies) { movie in
            NavigationLink {
                MoviePlayerView(movie: movie)
            } label: {
                Label(movie.title, systemImage: "film")
            }
        }
        .searchable(
            text: $searchText,
            prompt: "Search movies"
        )
        .navigationTitle("Search")
    }
}
