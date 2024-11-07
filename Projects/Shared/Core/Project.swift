import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeAppModule(
    name: "Core",
    targets: [.dynamicFramework],
    destinations: .macOS,
    deploymentTargets: .macOS(Configs.minimumTarget),
    packages: [],
    internalDependencies: [
        .thirdPartyLibs
    ]
)
