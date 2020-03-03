//
//  QueueManager.swift
//  FokoAssignment
//
//  Created by Rakesh Tripathi on 2020-02-26.
//  Copyright © 2020 Rakesh Tripathi. All rights reserved.
//

import Foundation

class QueueManager {

    lazy var networkQueue: OperationQueue = {
        let networkQueue = OperationQueue()
        return networkQueue
    }()

    // MARK: - Singleton
    static let shared = QueueManager()

    
    // MARK: - Addition
    func enqueueNetworkOperation(_ operation: Operation) {
        networkQueue.addOperation(operation)
    }
}
