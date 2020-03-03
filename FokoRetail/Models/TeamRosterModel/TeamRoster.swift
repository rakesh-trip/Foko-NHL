//
//  TeamRosterModel.swift
//  FokoAssignment
//
//  Created by Rakesh Tripathi on 2020-02-26.
//  Copyright © 2020 Rakesh Tripathi. All rights reserved.
//


// MARK: - TeamRosterModel
struct TeamRoster: Codable {
    var copyright: String?
    var roster: [Roster]?
    var link: String?
}
