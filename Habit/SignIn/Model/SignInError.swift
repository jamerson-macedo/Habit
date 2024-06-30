//
//  SignInError.swift
//  Habit
//
//  Created by Jamerson Macedo on 30/06/24.
//

import Foundation
struct SignInError : Decodable{
    let detail : SignInDetailErrorResponse
    enum CodingKeys :String, CodingKey{
        case detail
    }
}
struct SignInDetailErrorResponse :Decodable{
    let message : String
    enum CodingKeys : String, CodingKey{
        case message
    }
}
