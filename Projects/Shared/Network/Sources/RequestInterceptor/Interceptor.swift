//
//  Ingerceptor.swift
//  Network
//
//  Created by 강현준 on 11/6/24.
//  Copyright © 2024 clamp. All rights reserved.
//

import Foundation
import Moya
import Alamofire

final public class Interceptor: RequestInterceptor {
    
    public init() {
    }
    
    public func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        completion(.success(urlRequest))
    }

    public func retry(
        _ request: Request,
        for session: Session,
        dueTo error: any Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        completion(.doNotRetry)
    }
}
