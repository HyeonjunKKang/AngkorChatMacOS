//
//  MVIContainer.swift
//  Core
//
//  Created by 강현준 on 11/7/24.
//  Copyright © 2024 clamp. All rights reserved.
//

import Foundation
import Combine

public final class MVIContainer<Intent, Model>: ObservableObject {

    public let intent: Intent
    public let model: Model
    
    private var cancellalbe: Set<AnyCancellable> = []
    
    public init(
        intent: Intent,
        model: Model,
        modelChangePublisher: ObjectWillChangePublisher
    ) {
        self.intent = intent
        self.model = model
        
        modelChangePublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: objectWillChange.send)
            .store(in: &cancellalbe)
    }
}
