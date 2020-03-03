//
//  Venue.swift
//  FokoAssignment
//
//  Created by Rakesh Tripathi on 2020-02-26.
//  Copyright © 2020 Rakesh Tripathi. All rights reserved.
//

// MARK: - Venue
struct Venue: Codable {
    var name, link, city: String?
    var timeZone: TimeZone?
    var id: Int?
}
