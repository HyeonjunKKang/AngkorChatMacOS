//
//  LoggingEventMonitor.swift
//  Network
//
//  Created by 강현준 on 11/6/24.
//  Copyright © 2024 clamp. All rights reserved.
//

import Foundation
import Alamofire

final public class LoggingEventMonitor: EventMonitor {
    
    public var queue: DispatchQueue
    
    public init(
        queue: DispatchQueue = DispatchQueue(label: "NetworkLogger")
    ) {
        self.queue = queue
    }
    
    public func requestDidFinish(_ request: Request) {
        logRequestDidFinish(request: request)
    }
    
    public func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        logResponse(response: response)
    }
}

extension LoggingEventMonitor {
    func logRequestDidFinish(request: Request) {
        let url = request.request?.url?.absoluteString
        let method = request.request?.httpMethod
        var httpHeader: String = ""
        var requestBody: String = ""
        
        request.request?.allHTTPHeaderFields?.forEach {
            httpHeader += "\($0.key): \(String($0.value))\n"
        }
        
        if let httpBody = request.request?.httpBody, let bodyString = String(
            bytes: httpBody,
            encoding: .utf8
        ) {
            requestBody = "\n\(bodyString)"
        }
        
        print(
            "\n" +
            "🛰 V2 NETWORK Request LOG \n"
            + "URL: \(url ?? "")\n"
            + "Method: \(method ?? "")\n"
            + "Header: \n\(httpHeader)\n"
            + "RequestBody: \n\(requestBody)"
            + "\n[HTTP Request Ended]"
        )
        
    }
    
    func logResponse(response: DataResponse<Data?, AFError>) {
        let request = response.request
        let url = request?.url?.absoluteString
        let statusCode = response.response?.statusCode
        var httpHeader: String = ""
        
        response.response?.allHeaderFields.forEach {
            httpHeader.append("     \($0): \($1)\n")
        }
        
        var responseData = response.data?.toPrettyPrintedString
        
        print(
            """
            \n
            🛰 V2 NETWORK Response LOG \n
            URL: \(url ?? "")
            StatusCode: \(statusCode ?? 0)\n
            HTTPHeader: \n\(httpHeader)\n
            ResponseData: \n\(responseData ?? "")
            \n[HTTP Response End]\n
            """
        )
    }
}

extension Data {
    var toPrettyPrintedString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        return prettyPrintedString as String
    }
}
