//
//  Position.swift
//  FokoAssignment
//
//  Created by Rakesh Tripathi on 2020-02-26.
//  Copyright © 2020 Rakesh Tripathi. All rights reserved.
//

// MARK: - Position
struct Position: Codable {
    var code: Code?
    var name: Name?
    var type: TypeEnum?
    var abbreviation: TeamRosterAbbreviation?
}

enum TeamRosterAbbreviation: String, Codable {
    case c = "C"
    case d = "D"
    case g = "G"
    case lw = "LW"
    case rw = "RW"
}

enum Code: String, Codable {
    case c = "C"
    case d = "D"
    case g = "G"
    case l = "L"
    case r = "R"
}

enum Name: String, Codable {
    case center = "Center"
    case defenseman = "Defenseman"
    case goalie = "Goalie"
    case leftWing = "Left Wing"
    case rightWing = "Right Wing"
}

enum TypeEnum: String, Codable {
    case defenseman = "Defenseman"
    case forward = "Forward"
    case goalie = "Goalie"
}
