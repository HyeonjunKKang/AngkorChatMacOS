import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeAppModule(
    name: "AngkorChat-macOS-Release",
    targets: [.app],
    destinations: .macOS,
    deploymentTargets: .macOS(Configs.minimumTarget),
    packages: [],
    internalDependencies: [
        .Feature.root
    ]
)
