//
//  GetTeamDetailsOperation.swift
//  FokoRetail
//
//  Created by Rakesh Tripathi on 2020-02-28.
//  Copyright © 2020 Rakesh Tripathi. All rights reserved.
//

import Foundation

class GetTeamDetailsOperation: NetworkOperation<TeamRoster> {


    private let path = "teams/" + "\(TokenManager.teamId)" + "/roster"

init(completion: @escaping (TeamRoster?, RequestError?) -> Void) {
    super.init(method: .GET,path: path, body: nil, completion: completion)
    self.name = "Get Team Details Operation"
}
}
