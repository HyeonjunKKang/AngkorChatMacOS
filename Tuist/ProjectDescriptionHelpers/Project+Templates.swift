//
//  Project+Templates.swift
//  AngkorChatMacOSManifests
//
//  Created by 강현준 on 11/1/24.
//

import ProjectDescription

public enum FeatureTarget {
    case framework
    case tests
    case examples
    case testing
}

public enum ModuleTarget {
    case feature
    case core
    case architecture
}

public extension Target {
    static func makeAppTargets(
        name: String,
        dependencies: [String] = [],
        testeDependencies: [String] = []
    ) -> [Target] {
        let appConfigurations: [Configuration] = [
            .debug(
                name: "Debug", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/macOS/macOS-Application.xcconfig")
            ),
            .release(name: "Release", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/macOS/macOS-Application.xcconfig"))
        ]
        
        let testsConfigurations: [Configuration] = [
            .debug(name: "Debug", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/macOS/macOS-Base.xcconfig")),
            .debug(name: "Release", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/macOS/macOS-Base.xcconfig")),
        ]
        
        let targetDependencies: [TargetDependency] = dependencies.map {
            .target(name: $0)
        }
        
        return [
            Target.target(
                name: name,
                destinations: .macOS,
                product: .app,
                bundleId: "clamp.\(name)",
                deploymentTargets: .macOS(Configs.minimumTarget),
                infoPlist: .default,
                sources: ["\(Configs.appName)/Projects/App/\(name)/Sources/**/*.swift"],
                resources: ["\(Configs.appName)/Projects/App/\(name)/Resources/**/*"],
                dependencies: targetDependencies,
                settings: Settings.settings(configurations: appConfigurations)
            ),
            Target.target(
                name: "\(name)Tests",
                destinations: .macOS,
                product: .unitTests,
                bundleId: "clamp.\(name)Tests",
                infoPlist: .default,
                sources: ["\(Configs.appName)/Projects/App/\(name)/Tests/**/*.swift"],
                dependencies: [
                    .target(name: name, status: .required, condition: nil),
                    .xctest
                ] + testeDependencies.map { .target(name: $0) },
                settings: Settings.settings(configurations: testsConfigurations)
            )
        ]
    }
    
    static func makeFrameworkTargets(
        name: String,
        dependencies: [String] = [],
        testDependencies: [String] = [],
        externalDependencies: [String] = [],
        targets: Set<FeatureTarget> = Set([.framework, .tests, .examples, .testing]),
        moduleTarget: ModuleTarget,
        sdks: [String] = [],
        dependsOnXCTest: Bool = false,
        hasResource: Bool = false
    )  -> [Target] {
        // Configurations
        let frameworkConfigurations: [Configuration] = [
            .debug(name: "Debug", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/macOS/macOS-Framework.xcconfig")),
            .debug(name: "Release", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/macOS/macOS-Framework.xcconfig")),
        ]
        let testsConfigurations: [Configuration] = [
            .debug(name: "Debug", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/macOS/macOS-Base.xcconfig")),
            .debug(name: "Release", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/macOS/macOS-Base.xcconfig")),
        ]
        let appConfigurations: [Configuration] = [
            .debug(name: "Debug", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/macOS/macOS-Base.xcconfig")),
            .debug(name: "Release", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/macOS/macOS-Base.xcconfig")),
        ]
        
        // Test dependencies
        var targetTestDependencies: [TargetDependency] = [
            .target(name: "\(name)"),
            .xctest,
        ] + testDependencies.map({ .target(name: $0) })
//        dependencies.forEach { targetTestDependencies.append(.target(name: "\($0)Testing")) }
        
        // Target dependencies
        var targetDependencies: [TargetDependency] = dependencies.map {
            .target(name: $0)
        }
        
        var externalDependencies: [TargetDependency] = externalDependencies.map {
            .external(
                name: $0
            )
        }
        
        targetDependencies.append(
            contentsOf: sdks.map {
                .sdk(
                    name: $0,
                    type: .framework
                )
            })
        
        if dependsOnXCTest {
            targetDependencies.append(.xctest)
        }
        
        var sourcePathPrefix: String = ""
        
        switch moduleTarget {
        case .core:
            sourcePathPrefix = "\(Configs.appName)/Projects/Core/\(name)"
        case .feature:
            sourcePathPrefix = "\(Configs.appName)/Projects/Features/\(name)"
        case .architecture:
            sourcePathPrefix = "\(Configs.appName)/Projects/\(name)"
        }
        
        // Targets
        var projectTargets: [Target] = []
        if targets.contains(.framework) {
            projectTargets.append(
                Target.target(
                    name: name,
                    destinations: .macOS,
                    product: .framework,
                    bundleId: "clamp.\(name)",
                    deploymentTargets: .macOS(Configs.minimumTarget),
                    infoPlist: .default,
                    sources: "\(sourcePathPrefix)/Sources/**/*.swift",
                    resources: hasResource ? "\(sourcePathPrefix)/Resources/**/*.swift" : nil,
                    dependencies: targetDependencies + externalDependencies,
                    settings: Settings.settings(configurations: frameworkConfigurations)
                )
                
            )
        }
//        if targets.contains(.testing) {
//            projectTargets.append(
//                Target.target(
//                    name: "\(name)Testing",
//                    destinations: .macOS,
//                    product: .framework,
//                    bundleId: "clmap.\(name)Testing"
//                )
//            )
//        }
        if targets.contains(.tests) {
            projectTargets.append(
                Target.target(
                    name: "\(name)Tests",
                    destinations: .macOS,
                    product: .unitTests,
                    bundleId: "clamp.\(name)Tests",
                    infoPlist: .default,
                    sources: ["\(sourcePathPrefix)/Tests/**/*.swift"],
                    dependencies: targetTestDependencies,
                    settings: Settings.settings(configurations: testsConfigurations)
                )
            )
        }
        if targets.contains(.examples) {
            projectTargets.append(
                Target.target(
                    name: "\(name)Example",
                    destinations: .macOS,
                    product: .app,
                    bundleId: "clamp.\(name)Example",
                    infoPlist: .default,
                    sources: ["\(sourcePathPrefix)/Examples/Sources/**/*.swift"],
                    resources: ["\(sourcePathPrefix)/Examples/Resources/**/*.swift"],
                    dependencies: [.target(name: "\(name)")],
                    settings: Settings.settings(configurations: appConfigurations)
                )
            )
        }
        return projectTargets
    }
    
}
