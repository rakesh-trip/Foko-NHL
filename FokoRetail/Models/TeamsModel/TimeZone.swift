//
//  TimeZone.swift
//  FokoAssignment
//
//  Created by Rakesh Tripathi on 2020-02-26.
//  Copyright © 2020 Rakesh Tripathi. All rights reserved.
//

// MARK: - TimeZone
struct TimeZone: Codable {
    var id: String?
    var offset: Int?
    var tz: Timezones?
}

enum Timezones: String, Codable {
    case cst = "CST"
    case est = "EST"
    case mst = "MST"
    case pst = "PST"
}

