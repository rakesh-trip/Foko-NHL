//
//  TokenManager.swift
//  FokoRetail
//
//  Created by Rakesh Tripathi on 2020-02-28.
//  Copyright © 2020 Rakesh Tripathi. All rights reserved.
//

import Foundation
struct TokenManager {
    
    static let teamIdToken = "teamIDToken"
       
       static var teamId: Int {
           get {
            return UserDefaults.standard.integer(forKey: teamIdToken)
           }
           set {
               UserDefaults.standard.set(newValue, forKey: teamIdToken)
           }
       }
    
    static let playerIdToken = "playerIdToken"
          
          static var playerId: Int {
              get {
               return UserDefaults.standard.integer(forKey: playerIdToken)
              }
              set {
                  UserDefaults.standard.set(newValue, forKey: playerIdToken)
              }
          }
    
}
