import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeAppModule(
    name: "Domain",
    targets: [.dynamicFramework],
    destinations: .macOS,
    deploymentTargets: .macOS(Configs.minimumTarget),
    packages: [],
    internalDependencies: [
        .core
    ]
)
