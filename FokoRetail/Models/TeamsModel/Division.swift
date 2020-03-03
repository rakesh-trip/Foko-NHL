//
//  Division.swift
//  FokoAssignment
//
//  Created by Rakesh Tripathi on 2020-02-26.
//  Copyright © 2020 Rakesh Tripathi. All rights reserved.
//

// MARK: - Division
struct Division: Codable {
    var id: Int?
    var name: DivisionName?
    var nameShort: NameShort?
    var link: DivisionLink?
    var abbreviation: Abbreviation?
}

enum Abbreviation: String, Codable {
    case a = "A"
    case c = "C"
    case m = "M"
    case p = "P"
}

enum DivisionLink: String, Codable {
    case apiV1Divisions15 = "/api/v1/divisions/15"
    case apiV1Divisions16 = "/api/v1/divisions/16"
    case apiV1Divisions17 = "/api/v1/divisions/17"
    case apiV1Divisions18 = "/api/v1/divisions/18"
}

enum DivisionName: String, Codable {
    case atlantic = "Atlantic"
    case central = "Central"
    case metropolitan = "Metropolitan"
    case pacific = "Pacific"
}

enum NameShort: String, Codable {
    case atl = "ATL"
    case cen = "CEN"
    case metro = "Metro"
    case pac = "PAC"
}
