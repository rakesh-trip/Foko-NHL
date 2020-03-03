//
//  UIViewControllerExtension.swift
//  FokoAssignment
//
//  Created by Rakesh Tripathi on 2020-02-26.
//  Copyright © 2020 Rakesh Tripathi. All rights reserved.
//

import UIKit

extension UIViewController {
    func enqueueNetworkOperation<T : Codable>(operation: NetworkOperation<T>) {
        QueueManager.shared.enqueueNetworkOperation(operation)
    }
}
