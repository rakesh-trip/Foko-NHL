//
//  Franchise.swift
//  FokoAssignment
//
//  Created by Rakesh Tripathi on 2020-02-26.
//  Copyright © 2020 Rakesh Tripathi. All rights reserved.
//

// MARK: - Franchise
struct Franchise: Codable {
    var franchiseID: Int?
    var teamName, link: String?

    enum CodingKeys: String, CodingKey {
        case franchiseID = "franchiseId"
        case teamName, link
    }
}
