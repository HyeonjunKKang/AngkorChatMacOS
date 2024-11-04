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
        .debug(name: "DEV", xcconfig: Path.framework),
        .release(name: "PROD", xcconfig: Path.framework),
    ]
    
    public static func projectConfiguration(name: String, destination: Destinations) -> [Configuration] {
        return [
            .debug(name: "DEV", xcconfig: Path.xcconfigs(name: name, config: "DEV", destination: destination)),
            .release(name: "PROD", xcconfig: Path.xcconfigs(name: name, config: "PROD", destination: destination))
        ]
    }
}
