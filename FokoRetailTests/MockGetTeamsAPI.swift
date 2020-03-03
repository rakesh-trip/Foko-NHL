//
//  MockGetTeamsAPI.swift
//  FokoRetailTests
//
//  Created by Rakesh Tripathi on 2020-03-02.
//  Copyright © 2020 Rakesh Tripathi. All rights reserved.
//

import Foundation
@testable import FokoRetail
class MockGetTeamsAPI: GetTeamsOperation {
    
    var returnError: Bool? = false
    var errorType: RequestError.ErrorType? = nil
    var errorCode: Int? = nil
    
    var responseJSON = [
        "copyright": "NHL and the NHL Shield are registered trademarks of the National Hockey League. NHL and NHL team marks are the property of the NHL and its teams. © NHL 2020. All Rights Reserved."
    ]
    
    func reset() {
        returnError = false
        errorType = nil
        errorCode = nil
    }
    
    override func main() {
        
        if returnError == true {
            if errorCode != nil {
                let errorTemp = RequestError(statusCode: errorCode)
                self.completion(nil, errorTemp)
            } else {
                self.completion(nil, RequestError(errorType: self.errorType ?? .SomeError))
            }
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let jsonData = try JSONSerialization.data(withJSONObject: responseJSON, options: .prettyPrinted)

            let parsedJson = try decoder.decode(Teams.self, from: jsonData)
            self.completion(parsedJson, nil)
        } catch {
            // Parsing Error
            self.completion(nil, error as? RequestError)
        }
    }
}
