//
//  RefreshRequest.swift
//  Habit
//
//  Created by Jamerson Macedo on 01/07/24.
//

import Foundation

struct RefreshRequest: Encodable{
    let token : String
    enum CodingKeys :String, CodingKey{
        case token = "refresh_token"
    }
    
}
