// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SoundpipeAudioKit",
    platforms: [.macOS(.v10_13), .iOS(.v11), .tvOS(.v11)],
    products: [.library(name: "SoundpipeAudioKit", targets: ["SoundpipeAudioKit"])],
    dependencies: [
        .package(url: "https://github.com/AudioKit/KissFFT", from: "1.0.0"),
        .package(url: "https://github.com/overtune-app/AudioKit", .revision("77243f19117400dd4927b5ff1ee3b21a1d5ed11f")),
        .package(url: "https://github.com/overtune-app/AudioKitex", .revision("66b9203e32842d1af84d891805aaf30e205f9ad0")),
    ],
    targets: [
        .target(name: "Soundpipe",
                dependencies: [
                    .product(name: "Vapor", package: "vapor"),
                    "KissFFT"
                ],
                exclude: ["lib/inih/LICENSE.txt"],
                cSettings: [
                    .headerSearchPath("lib/inih"),
                    .headerSearchPath("Sources/soundpipe/lib/inih"),
                    .headerSearchPath("modules"),
                    .headerSearchPath("external")
                ]),
        .target(name: "SoundpipeAudioKit", dependencies: ["AudioKit", "AudioKitEX", "CSoundpipeAudioKit"]),
        .target(name: "CSoundpipeAudioKit", dependencies: ["AudioKit", "AudioKitEX", "Soundpipe"]),
        .testTarget(name: "SoundpipeAudioKitTests", dependencies: ["SoundpipeAudioKit"], resources: [.copy("TestResources/")]),
        .testTarget(name: "CSoundpipeAudioKitTests", dependencies: ["CSoundpipeAudioKit"]),
    ],
    cxxLanguageStandard: .cxx14
)
