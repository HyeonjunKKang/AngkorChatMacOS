//
//  XCConfig.swift
//  ProjectDescriptionHelpers
//
//  Created by 강현준 on 11/4/24.
//

import ProjectDescription

public struct XCConfig {
    private struct Path {
        static var framework: ProjectDescription.Path { .relativeToRoot("Configurations/Base/Base-Framework.xcconfig") }

        static func xcconfigs(name: String, config: String, destination: Destinations) -> ProjectDescription.Path {
            return .relativeToRoot("Configurations/Modules/\(name).xcconfig")
        }
    }
    
    public static let framework: [Configuration] = [
        .debug(name: "Debug", xcconfig: Path.framework),
        .release(name: "Release", xcconfig: Path.framework),
    ]
    
    public static func projectConfiguration(name: String, destination: Destinations) -> [Configuration] {
        return [
            .debug(name: "Debug", xcconfig: Path.xcconfigs(name: name, config: "Debug", destination: destination)),
            .release(name: "Release", xcconfig: Path.xcconfigs(name: name, config: "Release", destination: destination))
        ]
    }
}
