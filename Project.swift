import ProjectDescription
import ProjectDescriptionHelpers

let configurations: [Configuration] = [
    .debug(name: "Debug", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/Base/Configurations/Debug.xcconfig")),
    .debug(name: "Release", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/Base/Configurations/Release.xcconfig")),
]

func targets() -> [Target] {
    var targets: [Target] = []
    targets += ProjectTarget.App.app
    
    targets += ProjectTarget.Architecture.data
    targets += ProjectTarget.Architecture.domain
    targets += ProjectTarget.Feature.splashFeature
    targets += ProjectTarget.Feature.mainFeature
    targets += ProjectTarget.Modules.network
    targets += ProjectTarget.Modules.dsKit
    targets += ProjectTarget.Modules.core
    targets += ProjectTarget.Modules.thirdPartyLibs
    
    return targets
}





let project = Project(
    name: "AngkorChat",
    organizationName: "clamp",
    packages: [],
    settings: Settings.settings(configurations: configurations),
    targets: targets()
)
