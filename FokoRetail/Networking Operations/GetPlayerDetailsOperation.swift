//
//  GetPlayerDetailsOperation.swift
//  FokoRetail
//
//  Created by Rakesh Tripathi on 2020-02-29.
//  Copyright © 2020 Rakesh Tripathi. All rights reserved.
//
//
import Foundation

class GetPlayerOperation: NetworkOperation<Player> {
    private let path = "people/" + "\(TokenManager.playerId)"

    init(completion: @escaping (Player?, RequestError?) -> Void) {
        super.init(method: .GET,path: path, body: nil, completion: completion)
        self.name = "Get Player Details Operation"
    }
}
