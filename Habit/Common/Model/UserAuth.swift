//
//  UserAuth.swift
//  Habit
//
//  Created by Jamerson Macedo on 01/07/24.
//

import Foundation
// pode encodar e decodar
struct UserAuth : Codable{
    let idToken: String
    let refreshToken: String
    let expires: Double 
    let tokenType: String
    
    enum CodingKeys:String, CodingKey{
         case idToken = "access_token"
         case refreshToken = "refresh_token"
         case expires
         case tokenType = "token_type"
    }
}
