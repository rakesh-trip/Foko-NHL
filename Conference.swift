//
//  Conference.swift
//  FokoAssignment
//
//  Created by Rakesh Tripathi on 2020-02-26.
//  Copyright © 2020 Rakesh Tripathi. All rights reserved.
//

// MARK: - Conference
struct Conference: Codable {
    var id: Int?
    var name: ConferenceName?
    var link: ConferenceLink?
}

enum ConferenceLink: String, Codable {
    case apiV1Conferences5 = "/api/v1/conferences/5"
    case apiV1Conferences6 = "/api/v1/conferences/6"
}

enum ConferenceName: String, Codable {
    case eastern = "Eastern"
    case western = "Western"
}
