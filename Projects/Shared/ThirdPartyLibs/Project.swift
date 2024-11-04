import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeAppModule(
    name: "ThirdPartyLibs",
    targets: [.dynamicFramework],
    destinations: .macOS,
    deploymentTargets: .macOS("15.0"),
    packages: [],
    externalDependencies: [
        .moya,
        .swinject
    ]
)

