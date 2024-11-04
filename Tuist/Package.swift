// swift-tools-version: 5.9

@preconcurrency import PackageDescription

#if TUIST
import ProjectDescription
import ProjectDescriptionHelpers

    let packageSettings = PackageSettings(
        productTypes: [
            "Moya": .framework,
            "Swinject": .framework
        ],
        baseSettings: Settings.settings(configurations: XCConfig.framework)
    )
#endif

let package = Package(
    name: "AngkorChat",
    dependencies: [
        .package(url: "https://github.com/Moya/Moya", exact: "15.0.3"),
        .package(url: "https://github.com/Swinject/Swinject", exact: "2.9.1")
    ]
)
