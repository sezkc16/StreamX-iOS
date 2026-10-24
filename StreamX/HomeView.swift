
import SwiftUI

struct HomeView: View {
    @ObservedObject var manager: AddonManager

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {

                HStack {
                    Text("STREAMX")
                        .font(.system(size: 28, weight: .black))
                        .foregroundStyle(.red)

                    Spacer()

                    Image(systemName: "person.crop.circle")
                        .font(.title2)
                        .foregroundStyle(.white)
                }
                .padding(.top, 12)

                featuredSection

                HStack {
                    Text("Explore Movies")
                        .font(.title2.bold())

                    Spacer()

                    Text("\(manager.allMovies.count) Titles")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }

                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(manager.allMovies) { movie in
                        NavigationLink {
                            MoviePlayerView(movie: movie)
                        } label: {
                            movieCard(movie)
                        }
                        .buttonStyle(.plain)
                    }
                }

                if manager.allMovies.isEmpty {
                    ContentPlaceholder()
                }
            }
            .padding(.horizontal, 18)
            .padding(.bottom, 30)
        }
        .background(Color.black)
        .foregroundStyle(.white)
        .navigationBarHidden(true)
    }

    private var featuredSection: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.25, green: 0.1, blue: 0.15),
                            Color.black
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

            VStack(alignment: .leading, spacing: 14) {
                Spacer()

                Text("WELCOME TO STREAMX")
                    .font(.caption.bold())
                    .tracking(2)
                    .foregroundStyle(.red)

                Text("Unlimited Entertainment")
                    .font(.system(size: 32, weight: .bold))
                    .fixedSize(horizontal: false, vertical: true)

                Text("Discover movies from your installed add-ons.")
                    .font(.subheadline)
                    .foregroundStyle(.gray)

                if let movie = manager.allMovies.first {
                    NavigationLink {
                        MoviePlayerView(movie: movie)
                    } label: {
                        Label("Watch Now", systemImage: "play.fill")
                            .font(.headline)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                            .background(.red)
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(24)
        }
        .frame(height: 290)
    }

    private func movieCard(_ movie: StreamMovie) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(white: 0.12))

                Image(systemName: "film.fill")
                    .font(.system(size: 45))
                    .foregroundStyle(.gray)
            }
            .frame(height: 220)

            Text(movie.title)
                .font(.subheadline.bold())
                .lineLimit(2)
        }
    }
}

struct ContentPlaceholder: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "film.stack")
                .font(.system(size: 45))
                .foregroundStyle(.gray)

            Text("Your Library Is Empty")
                .font(.headline)

            Text("Install an add-on to discover movies.")
                .font(.subheadline)
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 50)
    }
}
