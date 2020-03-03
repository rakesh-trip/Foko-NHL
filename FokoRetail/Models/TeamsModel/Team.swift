//
//  Team.swift
//  FokoAssignment
//
//  Created by Rakesh Tripathi on 2020-02-26.
//  Copyright © 2020 Rakesh Tripathi. All rights reserved.
//

//import Foundation
//// MARK: - Team
//struct Team: Codable {
//    var id: Int?
//    var name, link: String?
//    var venue: Venue?
//    var abbreviation, teamName, locationName, firstYearOfPlay: String?
//    var division: Division?
//    var conference: Conference?
//    var franchise: Franchise?
//    var shortName: String?
//    var officialSiteURL: String?
//    var franchiseID: Int?
//    var active: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, link, venue, abbreviation, teamName, locationName, firstYearOfPlay, division, conference, franchise, shortName
//        case officialSiteURL = "officialSiteUrl"
//        case franchiseID = "franchiseId"
//        case active
//    }
//}



import Foundation
struct Team : Codable {
    let id : Int?
    let name : String?
    let link : String?
    let venue : Venue?
    let abbreviation : String?
    let teamName : String?
    let locationName : String?
    let firstYearOfPlay : String?
    let division : Division?
    let conference : Conference?
    let franchise : Franchise?
    let shortName : String?
    let officialSiteUrl : String?
    let franchiseId : Int?
    let active : Bool?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case link = "link"
        case venue = "venue"
        case abbreviation = "abbreviation"
        case teamName = "teamName"
        case locationName = "locationName"
        case firstYearOfPlay = "firstYearOfPlay"
        case division = "division"
        case conference = "conference"
        case franchise = "franchise"
        case shortName = "shortName"
        case officialSiteUrl = "officialSiteUrl"
        case franchiseId = "franchiseId"
        case active = "active"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        link = try values.decodeIfPresent(String.self, forKey: .link)
        venue = try values.decodeIfPresent(Venue.self, forKey: .venue)
        abbreviation = try values.decodeIfPresent(String.self, forKey: .abbreviation)
        teamName = try values.decodeIfPresent(String.self, forKey: .teamName)
        locationName = try values.decodeIfPresent(String.self, forKey: .locationName)
        firstYearOfPlay = try values.decodeIfPresent(String.self, forKey: .firstYearOfPlay)
        division = try values.decodeIfPresent(Division.self, forKey: .division)
        conference = try values.decodeIfPresent(Conference.self, forKey: .conference)
        franchise = try values.decodeIfPresent(Franchise.self, forKey: .franchise)
        shortName = try values.decodeIfPresent(String.self, forKey: .shortName)
        officialSiteUrl = try values.decodeIfPresent(String.self, forKey: .officialSiteUrl)
        franchiseId = try values.decodeIfPresent(Int.self, forKey: .franchiseId)
        active = try values.decodeIfPresent(Bool.self, forKey: .active)
    }

}

