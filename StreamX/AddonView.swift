
import SwiftUI

struct AddonView: View {
    
@ObservedObject var manager: AddonManager

    @State private var addonURL = ""
    @State private var isInstalling = false

    var body: some View {
        Form {
            Section("Install HTTP Add-on") {
                TextField(
                    "https://example.com/addon.json",
                    text: $addonURL
                )
                .keyboardType(.URL)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()

                Button {
                    Task {
                        isInstalling = true
                        await manager.installAddon(
                            from: addonURL
                        )
                        isInstalling = false
                    }
                } label: {
                    if isInstalling {
                        ProgressView()
                    } else {
                        Label(
                            "Install Add-on",
                            systemImage: "plus.circle.fill"
                        )
                    }
                }
                .disabled(
                    isInstalling ||
                    addonURL.trimmingCharacters(
                        in: .whitespacesAndNewlines
                    ).isEmpty
                )
            }

            if let error = manager.errorMessage {
                Section {
                    Text(error)
                        .foregroundStyle(.red)
                }
            }

            Section("Installed Add-ons") {
                if manager.addons.isEmpty {
                    Text("No add-ons installed yet")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(manager.addons) { addon in
                        VStack(
                            alignment: .leading,
                            spacing: 6
                        ) {
                            Text(addon.name)
                                .font(.headline)

                            Text(addon.description)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)

                            Text("Version \(addon.version)")
                                .font(.caption)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle("Add-ons")
    }
}
