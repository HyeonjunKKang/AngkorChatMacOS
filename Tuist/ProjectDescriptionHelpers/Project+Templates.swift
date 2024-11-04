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
        let configurationName: ConfigurationName = "DEV"
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
        
        
        return Project(
            name: name,
            organizationName: Configs.organizationName,
            packages: packages,
            settings: .settings(configurations: configuration),
            targets: projectTargets,
            schemes: [
                targets.contains(.demo)
                ? Scheme.makeDemoScheme(configs: "DEV", name: name)
                : Scheme.makeScheme(configs: "PROD", name: name)
            ]
        )
    }
}

//public extension Target {
//    static func makeAppTargets(
//        name: String,
//        dependencies: [String] = [],
//        testeDependencies: [String] = []
//    ) -> [Target] {
//        let appConfigurations: [Configuration] = [
//            .debug(
//                name: "Debug", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/macOS/macOS-Application.xcconfig")
//            ),
//            .release(name: "Release", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/macOS/macOS-Application.xcconfig"))
//        ]
//        
//        let testsConfigurations: [Configuration] = [
//            .debug(name: "Debug", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/macOS/macOS-Base.xcconfig")),
//            .debug(name: "Release", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/macOS/macOS-Base.xcconfig")),
//        ]
//        
//        let targetDependencies: [TargetDependency] = dependencies.map {
//            .target(name: $0)
//        }
//        
//        return [
//            Target.target(
//                name: name,
//                destinations: .macOS,
//                product: .app,
//                bundleId: "clamp.\(name)",
//                deploymentTargets: .macOS(Configs.minimumTarget),
//                infoPlist: .default,
//                sources: ["\(Configs.appName)/Projects/AppModule/\(name)/Sources/**/*.swift"],
//                resources: ["\(Configs.appName)/Projects/AppModule/\(name)/Resources/**/*"],
//                dependencies: targetDependencies,
//                settings: Settings.settings(configurations: appConfigurations)
//            ),
//            Target.target(
//                name: "\(name)Tests",
//                destinations: .macOS,
//                product: .unitTests,
//                bundleId: "clamp.\(name)Tests",
//                infoPlist: .default,
//                sources: ["\(Configs.appName)/Projects/App/\(name)/Tests/**/*.swift"],
//                dependencies: [
//                    .target(name: name, status: .required, condition: nil),
//                    .xctest
//                ] + testeDependencies.map { .target(name: $0) },
//                settings: Settings.settings(configurations: testsConfigurations)
//            )
//        ]
//    }
//    
//    static func makeFrameworkTargets(
//        name: String,
//        dependencies: [String] = [],
//        testDependencies: [TargetDependency] = [],
//        externalDependencies: [TargetDependency] = [],
//        targets: Set<FeatureTarget> = Set([.framework, .tests, .examples, .testing]),
//        moduleTarget: ModuleTarget,
//        sdks: [String] = [],
//        dependsOnXCTest: Bool = false,
//        hasResource: Bool = false
//    )  -> [Target] {
//        // Configurations
//        let frameworkConfigurations: [Configuration] = [
//            .debug(name: "Debug", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/macOS/macOS-Framework.xcconfig")),
//            .debug(name: "Release", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/macOS/macOS-Framework.xcconfig")),
//        ]
//        let testsConfigurations: [Configuration] = [
//            .debug(name: "Debug", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/macOS/macOS-Base.xcconfig")),
//            .debug(name: "Release", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/macOS/macOS-Base.xcconfig")),
//        ]
//        let appConfigurations: [Configuration] = [
//            .debug(name: "Debug", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/macOS/macOS-Base.xcconfig")),
//            .debug(name: "Release", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/macOS/macOS-Base.xcconfig")),
//        ]
//        
//        // Target dependencies
//        var targetDependencies: [TargetDependency] = dependencies.map {
//            .target(name: $0)
//        }
//
//        targetDependencies.append(
//            contentsOf: sdks.map {
//                .sdk(
//                    name: $0,
//                    type: .framework
//                )
//            })
//        
//        if dependsOnXCTest {
//            targetDependencies.append(.xctest)
//        }
//        
//        var sourcePathPrefix: String = ""
//        
//        switch moduleTarget {
//        case .core:
//            sourcePathPrefix = "\(Configs.appName)/Projects/Core/\(name)"
//        case .feature:
//            sourcePathPrefix = "\(Configs.appName)/Projects/Features/\(name)"
//        case .architecture:
//            sourcePathPrefix = "\(Configs.appName)/Projects/\(name)"
//        }
//        
//        // Targets
//        var projectTargets: [Target] = []
//        if targets.contains(.framework) {
//            projectTargets.append(
//                Target.target(
//                    name: name,
//                    destinations: .macOS,
//                    product: .staticLibrary,
//                    bundleId: "clamp.\(name)",
//                    deploymentTargets: .macOS(Configs.minimumTarget),
//                    infoPlist: .default,
//                    sources: "\(sourcePathPrefix)/Sources/**/*.swift",
//                    resources: hasResource ? "\(sourcePathPrefix)/Resources/**/*.swift" : nil,
//                    dependencies: targetDependencies + externalDependencies,
//                    settings: Settings.settings(configurations: frameworkConfigurations)
//                )
//            )
//        }
//        
//        if targets.contains(.tests) {
//            projectTargets.append(
//                Target.target(
//                    name: "\(name)Tests",
//                    destinations: .macOS,
//                    product: .unitTests,
//                    bundleId: "clamp.\(name)Tests",
//                    infoPlist: .default,
//                    sources: ["\(sourcePathPrefix)/Tests/**/*.swift"],
//                    dependencies: targetDependencies + externalDependencies,
//                    settings: Settings.settings(configurations: testsConfigurations)
//                )
//            )
//        }
//        if targets.contains(.examples) {
//            projectTargets.append(
//                Target.target(
//                    name: "\(name)Example",
//                    destinations: .macOS,
//                    product: .app,
//                    bundleId: "clamp.\(name)Example",
//                    infoPlist: .default,
//                    sources: ["\(sourcePathPrefix)/Examples/Sources/**/*.swift"],
//                    resources: ["\(sourcePathPrefix)/Examples/Resources/**/*.swift"],
//                    dependencies: [.target(name: "\(name)")],
//                    settings: Settings.settings(configurations: appConfigurations)
//                )
//            )
//        }
//        return projectTargets
//    }
//    
//}
