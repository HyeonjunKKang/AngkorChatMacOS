//
//  Project.swift
//  AngkorChat-macOS-DEVManifests
//
//  Created by 강현준 on 11/4/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeAppModule(
    name: "RootFeature",
    targets: [.dynamicFramework],
    destinations: .macOS,
    deploymentTargets: .macOS(Configs.minimumTarget),
    packages: [],
    internalDependencies: [
        .data,
        .Feature.splash,
        .Feature.main
    ]
)

