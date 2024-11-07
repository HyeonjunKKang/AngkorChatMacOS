import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeAppModule(
    name: "BaseFeatureInterface",
    targets: [.dynamicFramework],
    destinations: .macOS,
    deploymentTargets: .macOS(Configs.minimumTarget),
    packages: [],
    internalDependencies: [
        .dsKit,
        .domain
    ]
)

