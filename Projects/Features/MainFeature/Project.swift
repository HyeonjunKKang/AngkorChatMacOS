import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeAppModule(
    name: "MainFeature",
    targets: [.dynamicFramework, .demo],
    destinations: .macOS,
    deploymentTargets: .macOS("15.0"),
    packages: [],
    internalDependencies: [
        .domain
    ]
)
