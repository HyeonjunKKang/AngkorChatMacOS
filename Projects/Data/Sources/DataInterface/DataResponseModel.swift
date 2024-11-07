//
//  DataResponseModel.swift
//  Data
//
//  Created by 강현준 on 11/7/24.
//  Copyright © 2024 clamp. All rights reserved.
//

import Foundation
import Domain

public protocol DataResponseModel: Decodable {
    func toDomain() -> DomainModel
}
