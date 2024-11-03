// swift-tools-version: 5.9
@preconcurrency import PackageDescription
import ProjectDescriptionHelpers

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,]
        productTypes: [
            "Moya": .staticFramework
        ],
        baseSettings: .settings(
            configurations: [
                .debug(name: .debug),
                .debug(name: .release)
            ]
        )
    )
#endif

let package = Package(
    name: "AngkorChat",
    platforms: [.macOS(Configs.minimumTarget)],
    dependencies: [
        // Add your own dependencies here:
        // .package(url: "https://github.com/Alamofire/Alamofire", from: "5.0.0"),
        // You can read more about dependencies here: https://docs.tuist.io/documentation/tuist/dependencies
        
        .package(url: "https://github.com/Moya/Moya", exact: "15.0.3")
    ]
)
