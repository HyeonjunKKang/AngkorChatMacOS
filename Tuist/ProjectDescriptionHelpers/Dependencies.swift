//
//  Dependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by 강현준 on 11/4/24.
//

import ProjectDescription

// MARK: - Internal
public extension TargetDependency {
    
    struct Feature {
        public static let splash: TargetDependency = .project(
            target: "SplashFeature",
            path: .relativeToRoot(
                "Projects/Features/SplashFeature"
            )
        )
        public static let root: TargetDependency = .project(
            target: "RootFeature",
            path: .relativeToRoot(
                "Projects/Features/RootFeature"
            )
        )
        
        public static let main: TargetDependency = .project(
            target: "MainFeature",
            path: .relativeToRoot(
                "Projects/Features/MainFeature"
            )
        )
    }
    
    static let data: TargetDependency = .project(
        target: "Data",
        path: .relativeToRoot("Projects/Data")
    )
    
    static let domain: TargetDependency = .project(
        target: "Domain",
        path: .relativeToRoot("Projects/Domain")
    )
    
    static let core: TargetDependency = .project(
        target: "Core",
        path: .relativeToRoot("Projects/Shared/Core")
    )
    
    static let thirdPartyLibs: TargetDependency = .project(
        target: "ThirdPartyLibs",
        path: .relativeToRoot("Projects/Shared/ThirdPartyLibs")
    )
    
    static let network: TargetDependency = .project(
            target: "Network",
            path: .relativeToRoot("Projects/Shared/Network")
    )
}

// MARK: - External {
public extension TargetDependency {
    static let moya: TargetDependency = .external(name: "Moya")
    static let swinject: TargetDependency = .external(name: "Swinject")
}
