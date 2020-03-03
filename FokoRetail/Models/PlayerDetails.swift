//
//  PersonModel.swift
//  FokoRetail
//
//  Created by Rakesh Tripathi on 2020-02-29.
//  Copyright © 2020 Rakesh Tripathi. All rights reserved.
//

import Foundation
// MARK: - Person
struct PlayerDetails: Codable {
    var id: Int?
    var fullName, link, firstName, lastName: String?
    var primaryNumber, birthDate: String?
    var currentAge: Int?
    var birthCity, birthCountry, nationality, height: String?
    var weight: Int?
    var active, alternateCaptain, captain, rookie: Bool?
    var shootsCatches, rosterStatus: String?
    var currentTeam: CurrentTeam?
    var primaryPosition: PrimaryPosition?
}
