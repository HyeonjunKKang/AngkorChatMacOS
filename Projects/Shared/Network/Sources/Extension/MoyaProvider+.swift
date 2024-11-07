//
//  MoyaProvider_.swift
//  Network
//
//  Created by 강현준 on 11/6/24.
//  Copyright © 2024 clamp. All rights reserved.
//

import Foundation
import Moya

extension MoyaProvider {
    func request<D: Decodable>(_ target: Target) async throws -> D {
        return try await withCheckedThrowingContinuation { continuation in
            self.request(target) { response in
                switch response {
                case .success(let responseData):
                    do {
                        let filteredData = try responseData.filterSuccessfulStatusCodes()
                        let decoded = try JSONDecoder().decode(D.self, from: filteredData.data)
                        continuation.resume(returning: decoded)

                    } catch let error {
                        continuation.resume(throwing: error)
                    }
                case .failure(let moyaError):
                    continuation.resume(throwing: moyaError)
                }
            }
        }
    }
    
    func request(_ target: Target) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            self.request(target) { response in
                switch response {
                case .success(let responseData):
                    do {
                        let filteredData = try responseData.filterSuccessfulStatusCodes()
                        continuation.resume()
                    } catch let error {
                        continuation.resume(throwing: error)
                    }
                case .failure(let moyaError):
                    continuation.resume(throwing: moyaError)
                }
            }
        }
    }
}
