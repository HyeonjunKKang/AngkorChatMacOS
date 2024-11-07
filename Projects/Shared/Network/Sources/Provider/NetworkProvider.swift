//
//  NetworkProvider.swift
//  Network
//
//  Created by 강현준 on 11/6/24.
//  Copyright © 2024 clamp. All rights reserved.
//

import Foundation
import Moya
import Alamofire

final public class NetworkProvider<T: TargetType>: MoyaProvider<T> {
    
    public init(
        interceptor: RequestInterceptor? = Interceptor(),
        eventMonitors: [EventMonitor] = [LoggingEventMonitor()],
        plugins: [PluginType]
    ) {
        let session = Session(
            configuration: .default,
            interceptor: interceptor,
            eventMonitors: eventMonitors
        )
        
        super.init(
            session: session,
            plugins: plugins
        )
    }
}
