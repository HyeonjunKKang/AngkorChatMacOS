import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeAppModule(
    name: "SplashFeature",
    targets: [.dynamicFramework, .demo],
    destinations: .macOS,
    deploymentTargets: .macOS(Configs.minimumTarget),
    packages: [],
    internalDependencies: [
        .Feature.baseFeatureInterface
    ]
)
