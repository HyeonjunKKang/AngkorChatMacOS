import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeAppModule(
    name: "Network",
    targets: [.dynamicFramework],
    destinations: .macOS,
    deploymentTargets: .macOS(Configs.minimumTarget),
    packages: [],
    internalDependencies: [
        .domain
    ]
)
