//
//  Project+Templates.swift
//  AngkorChatMacOSManifests
//
//  Created by 강현준 on 11/1/24.
//

import ProjectDescription

public enum FeatureTarget {
    case tests
    case demo
    case testing
    case app
    case dynamicFramework
    case staticFramework
    
    var isFramework: Bool {
        switch self {
        case .dynamicFramework, .staticFramework:
            return true
        default:
            return false
        }
    }
}

public extension Project {
    static func makeAppModule(
        name: String,
        targets: Set<FeatureTarget>,
        hasResources: Bool = false ,
        destinations: Destinations,
        deploymentTargets: DeploymentTargets,
        packages: [Package],
        internalDependencies: [TargetDependency] = [],  // 모듈간 의존성
        externalDependencies: [TargetDependency] = []  // 외부 라이브러리 의존성
    ) -> Project {
        
        var projectTargets: [Target] = []
        let configurationName: ConfigurationName = "Debug"
        let baseSettings: SettingsDictionary = .baseSettings
        let configuration: [Configuration] = XCConfig.projectConfiguration(name: name, destination: destinations)
        let bundleIDPrefix: String = Configs.bundleIDPrefix

        if targets.contains(.app) {
            let setting = baseSettings.setAutomaticProvisioning()
            projectTargets.append(
                .target(
                    name: name,
                    destinations: destinations,
                    product: .app,
                    bundleId: "\(bundleIDPrefix).\(name)",
                    deploymentTargets: deploymentTargets,
                    infoPlist: .default,
                    sources: ["Sources/**/*.swift"],
                    entitlements: "\(name).entitlements",
                    scripts: [],
                    dependencies: [
                        internalDependencies, externalDependencies
                    ].flatMap { $0 },
                    settings: .settings(base: setting, configurations: configuration)
                )
            )
        }
        
        // MARK: - Demo Module
        if targets.contains(.demo) {
            let setting = baseSettings.setAutomaticProvisioning()
            let dependencies: [TargetDependency] = [
                .target(name: name)
            ]
            
            projectTargets.append(
                .target(
                    name: "\(name)Demo",
                    destinations: destinations,
                    product: .app,
                    bundleId: "\(bundleIDPrefix).\(name)Demo",
                    deploymentTargets: deploymentTargets,
                    infoPlist: .default,
                    sources: "Demo/Sources/**/*.swift",
                    dependencies: dependencies,
                    settings: .settings(base: setting, configurations: configuration)
                )
            )

        }
        
        // MARK: - Framework Source
        if targets.contains(where: { $0.isFramework }) {
            
            let setting = baseSettings.setAutomaticProvisioning()
            
            projectTargets.append(
                .target(
                    name: name,
                    destinations: destinations,
                    product: targets.contains(.dynamicFramework) ? .framework : .staticFramework,
                    bundleId: "\(bundleIDPrefix).\(name)",
                    deploymentTargets: deploymentTargets,
                    infoPlist: .default,
                    sources: ["Sources/**/*.swift"],
                    resources: hasResources ? ["Resources/**"] : nil,
                    scripts: [],
                    dependencies: [internalDependencies, externalDependencies].flatMap { $0 },
                    settings: .settings(base: setting)
                )
            )
        }
        
        var schemes: [Scheme] = []
        if targets.contains(.demo) || name.contains("Debug") {
            schemes.append(Scheme.makeDemoScheme(configs: "Debug", name: name))
        } else {
            schemes.append(Scheme.makeScheme(configs: "Release", name: name))
        }
        
        return Project(
            name: name,
            organizationName: Configs.organizationName,
            packages: packages,
            settings: .settings(configurations: configuration),
            targets: projectTargets,
            schemes: schemes
        )
    }
}
