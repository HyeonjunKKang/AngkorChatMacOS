import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeAppModule(
    name: "ThirdPartyLibs",
    targets: [.staticFramework],
    destinations: .macOS,
    deploymentTargets: .macOS(Configs.minimumTarget),
    packages: [],
    externalDependencies: [
        .moya,
        .swinject
    ]
)

