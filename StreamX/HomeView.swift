


import SwiftUI

struct HomeView: View {
    @ObservedObject var manager: AddonManager

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    header

                    featuredSection
                        .frame(height: min(
                            geometry.size.height * 0.32,
                            240
                        ))

                    HStack {
                        Text("Explore Movies")
                            .font(.title3.bold())

                        Spacer()

                        Text("\(manager.allMovies.count) Titles")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }

                    if manager.allMovies.isEmpty {
                        ContentPlaceholder()
                    } else {
                        LazyVGrid(
                            columns: columns,
                            spacing: 16
                        ) {
                            ForEach(manager.allMovies) { movie in
                                NavigationLink {
                                    MoviePlayerView(movie: movie)
                                } label: {
                                    movieCard(movie)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .padding(.bottom, 24)
            }
            .scrollIndicators(.hidden)
        }
        .background(Color.black.ignoresSafeArea())
        .foregroundStyle(.white)
        .toolbar(.hidden, for: .navigationBar)
    }

    private var header: some View {
        HStack {
            Text("STREAMX")
                .font(.system(size: 25, weight: .black))
                .foregroundStyle(.red)

            Spacer()

            Image(systemName: "person.crop.circle")
                .font(.title2)
        }
    }

    private var featuredSection: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.3, green: 0.1, blue: 0.15),
                            Color(red: 0.08, green: 0.08, blue: 0.1)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            VStack(alignment: .leading, spacing: 10) {
                Spacer(minLength: 0)

                Text("STREAMX ORIGINAL")
                    .font(.system(size: 10, weight: .bold))
                    .tracking(2)
                    .foregroundStyle(.red)

                Text("Unlimited\nEntertainment")
                    .font(.system(size: 26, weight: .bold))
                    .fixedSize(
                        horizontal: false,
                        vertical: true
                    )

                Text("Your movies. Your experience.")
                    .font(.caption)
                    .foregroundStyle(.gray)

                if let movie = manager.allMovies.first {
                    NavigationLink {
                        MoviePlayerView(movie: movie)
                    } label: {
                        Label("Watch Now", systemImage: "play.fill")
                            .font(.subheadline.bold())
                            .padding(.horizontal, 16)
                            .padding(.vertical, 9)
                            .background(.red)
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(18)
        }
    }

    private func movieCard(_ movie: StreamMovie) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(white: 0.14))
                .overlay {
                    Image(systemName: "film.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.gray)
                }
                .aspectRatio(0.72, contentMode: .fit)

            Text(movie.title)
                .font(.subheadline.bold())
                .lineLimit(2)
        }
    }
}

struct ContentPlaceholder: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "film.stack")
                .font(.largeTitle)
                .foregroundStyle(.gray)

            Text("No Movies Yet")
                .font(.headline)

            Text("Install an add-on to start watching.")
                .font(.caption)
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 25)
    }
}
   ]

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    header

                    featuredSection
                        .frame(height: min(
                            geometry.size.height * 0.32,
                            240
                        ))

                    HStack {
                        Text("Explore Movies")
                            .font(.title3.bold())

                        Spacer()

                        Text("\(manager.allMovies.count) Titles")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }

                    if manager.allMovies.isEmpty {
                        ContentPlaceholder()
                    } else {
                        LazyVGrid(
                            columns: columns,
                            spacing: 16
                        ) {
                            ForEach(manager.allMovies) { movie in
                                NavigationLink {
                                    MoviePlayerView(movie: movie)
                                } label: {
                                    movieCard(movie)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .padding(.bottom, 24)
            }
            .scrollIndicators(.hidden)
        }
        .background(Color.black.ignoresSafeArea())
        .foregroundStyle(.white)
        .toolbar(.hidden, for: .navigationBar)
    }

    private var header: some View {
        HStack {
            Text("STREAMX")
                .font(.system(size: 25, weight: .black))
                .foregroundStyle(.red)

            Spacer()

            Image(systemName: "person.crop.circle")
                .font(.title2)
        }
    }

    private var featuredSection: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.3, green: 0.1, blue: 0.15),
                            Color(red: 0.08, green: 0.08, blue: 0.1)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            VStack(alignment: .leading, spacing: 10) {
                Spacer(minLength: 0)

                Text("STREAMX ORIGINAL")
                    .font(.system(size: 10, weight: .bold))
                    .tracking(2)
                    .foregroundStyle(.red)

                Text("Unlimited\nEntertainment")
                    .font(.system(size: 26, weight: .bold))
                    .fixedSize(
                        horizontal: false,
                        vertical: true
                    )

                Text("Your movies. Your experience.")
                    .font(.caption)
                    .foregroundStyle(.gray)

                if let movie = manager.allMovies.first {
                    NavigationLink {
                        MoviePlayerView(movie: movie)
                    } label: {
                        Label("Watch Now", systemImage: "play.fill")
                            .font(.subheadline.bold())
                            .padding(.horizontal, 16)
                            .padding(.vertical, 9)
                            .background(.red)
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(18)
        }
    }

    private func movieCard(_ movie: StreamMovie) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(white: 0.14))
                .overlay {
                    Image(systemName: "film.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.gray)
                }
                .aspectRatio(0.72, contentMode: .fit)

            Text(movie.title)
                .font(.subheadline.bold())
                .lineLimit(2)
        }
    }
}

struct ContentPlaceholder: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "film.stack")
                .font(.largeTitle)
                .foregroundStyle(.gray)

            Text("No Movies Yet")
                .font(.headline)

            Text("Install an add-on to start watching.")
                .font(.caption)
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 25)
    }
}
