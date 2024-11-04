//
//  SettingDictionary.swift
//  ProjectDescriptionHelpers
//
//  Created by 강현준 on 11/4/24.
//

import Foundation

import ProjectDescription

public extension SettingsDictionary {
    
    // BaseSetting
    static let baseSettings: Self = [
        "OTHER_LDFLAGS" : [
            "$(inherited)",
            "-ObjC"
        ]
    ]
    
    // Automatic Provisioning
    func setAutomaticProvisioning() -> SettingsDictionary {
        merging(["CODE_SIGN_STYLE": SettingValue(stringLiteral: "Automatic")])
            .merging(["CODE_SIGN_STYLE": SettingValue(stringLiteral: "Automatic")])
    }
}
