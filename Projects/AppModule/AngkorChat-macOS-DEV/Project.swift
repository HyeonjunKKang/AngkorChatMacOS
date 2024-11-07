import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeAppModule(
    name: "AngkorChat-macOS-Debug",
    targets: [.app],
    destinations: .macOS,
    deploymentTargets: .macOS("15.0"),
    packages: [],
    internalDependencies: [
        .Feature.root
    ]
)
