import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeAppModule(
    name: "Data",
    targets: [.dynamicFramework],
    destinations: .macOS,
    deploymentTargets: .macOS(Configs.minimumTarget),
    packages: [],
    internalDependencies: [
        .network
    ]
)
