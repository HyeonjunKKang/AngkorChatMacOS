import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeAppModule(
    name: "Core",
    targets: [.dynamicFramework],
    destinations: .macOS,
    deploymentTargets: .macOS("15.0"),
    packages: [],
    internalDependencies: [
        .thirdPartyLibs
    ]
)
