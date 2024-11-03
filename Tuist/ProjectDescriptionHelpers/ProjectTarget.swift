//
//  Targets.swift
//  AngkorChatMacOSManifests
//
//  Created by 강현준 on 11/1/24.
//

import ProjectDescription

public enum ProjectTarget {
    
}

public extension ProjectTarget {
    struct App {
        public static let app = Target.makeAppTargets(name: "\(Configs.appName)", dependencies: ["SplashFeature", "MainFeature", "Data"])
    }
}

public extension ProjectTarget {
    struct Feature {
        public static let splashFeature = Target.makeFrameworkTargets(
            name: "SplashFeature",
            dependencies: ["Domain", "DSKit"],
            targets: .init(arrayLiteral: .framework, .tests, .testing),
            moduleTarget: .feature
        )
        
        public static let mainFeature = Target.makeFrameworkTargets(
            name: "MainFeature",
            dependencies: ["Domain", "DSKit"],
            targets: .init(arrayLiteral: .framework, .tests, .testing),
            moduleTarget: .feature
        )
    }
}

public extension ProjectTarget {
    struct Architecture {
        public static let domain = Target.makeFrameworkTargets(
            name: "Domain",
            dependencies: ["Core"],
            targets: Set([.framework]),
            moduleTarget: .architecture
        )
        public static let data = Target.makeFrameworkTargets(
            name: "Data",
            dependencies: ["Network"],
            targets: Set([.framework]),
            moduleTarget: .architecture
        )
    }
}

public extension ProjectTarget {
    struct Modules {
        public static let network = Target.makeFrameworkTargets(
            name: "Network",
            dependencies: ["Domain"],
            targets: Set([.framework]),
            moduleTarget: .core
        )
        public static let dsKit = Target.makeFrameworkTargets(
            name: "DSKit",
            dependencies: ["ThirdPartyLibs"],
            targets: Set([.framework]),
            moduleTarget: .core,
            hasResource: true
        )
        public static let core = Target.makeFrameworkTargets(
            name: "Core",
            dependencies: ["ThirdPartyLibs"],
            targets: Set([.framework]),
            moduleTarget: .core
        )
        public static let thirdPartyLibs = Target.makeFrameworkTargets(
            name: "ThirdPartyLibs",
            externalDependencies: ["Moya"],
            targets: Set([.framework]),
            moduleTarget: .core
        )
    }
}
