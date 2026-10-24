

import Foundation
import Combine

struct StreamMovie: Codable, Identifiable {
    let id: String
    let title: String
    let type: String
    let streamUrl: String
}

struct StreamAddon: Codable, Identifiable {
    let id: String
    let name: String
    let version: String
    let description: String
    let baseUrl: String
    let catalog: [StreamMovie]?
}

@MainActor
class AddonManager: ObservableObject {
    @Published var addons: [StreamAddon] = []
    @Published var errorMessage: String?

    var allMovies: [StreamMovie] {
        addons.flatMap { $0.catalog ?? [] }
    }

    func installAddon(from urlString: String) async {
        errorMessage = nil

        guard let url = URL(string: urlString),
              url.scheme?.lowercased() == "https",
              url.host != nil else {
            errorMessage = "Enter a valid HTTPS add-on URL."
            return
        }

        do {
            var request = URLRequest(url: url)
            request.timeoutInterval = 15

            let (data, response) = try await URLSession.shared.data(
                for: request
            )

            guard let http = response as? HTTPURLResponse,
                  (200...299).contains(http.statusCode) else {
                errorMessage = "Unable to download add-on."
                return
            }

            guard data.count <= 1_000_000 else {
                errorMessage = "Add-on manifest is too large."
                return
            }

            let addon = try JSONDecoder().decode(
                StreamAddon.self,
                from: data
            )

            guard let baseURL = URL(string: addon.baseUrl),
                  baseURL.scheme?.lowercased() == "https",
                  baseURL.host != nil else {
                errorMessage = "Invalid add-on base URL."
                return
            }

            let validMovies = (addon.catalog ?? []).allSatisfy {
                guard let streamURL = URL(string: $0.streamUrl) else {
                    return false
                }

                return streamURL.scheme?.lowercased() == "https"
                    && streamURL.host != nil
            }

            guard validMovies else {
                errorMessage = "Invalid catalog stream URL."
                return
            }

            if let index = addons.firstIndex(
                where: { $0.id == addon.id }
            ) {
                addons[index] = addon
            } else {
                addons.append(addon)
            }
        } catch {
            errorMessage = "Install failed: \(error.localizedDescription)"
        }
    }
}
