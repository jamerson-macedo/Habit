//
//  SignInResponse.swift
//  Habit
//
//  Created by Jamerson Macedo on 30/06/24.
//

import Foundation
struct SignInResponse : Decodable{
    // valores que a api retorna
    let accessToken: String
    let refreshToken: String
    let expires: Int
    let tokenType: String
    
    enum CodingKeys:String, CodingKey{
         case accessToken = "access_token"
         case refreshToken = "refresh_token"
         case expires
         case tokenType = "token_type"
    }
}
