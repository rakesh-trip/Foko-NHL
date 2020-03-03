//
//  GetTeamsOperation.swift
//  FokoAssignment
//
//  Created by Rakesh Tripathi on 2020-02-26.
//  Copyright © 2020 Rakesh Tripathi. All rights reserved.
//

import Foundation

class GetTeamsOperation: NetworkOperation<Teams> {
    private let path = "teams"
    init(completion: @escaping (Teams?, RequestError?) -> Void) {
        super.init(method: .GET,path: path, body: nil, completion: completion)
        self.name = "Get Teams Operation"
    }
}
