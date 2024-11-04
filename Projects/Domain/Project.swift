import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeAppModule(
    name: "Domain",
    targets: [.dynamicFramework],
    destinations: .macOS,
    deploymentTargets: .macOS("15.0"),
    packages: [],
    internalDependencies: [
        .core
    ]
)
