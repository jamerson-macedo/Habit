//
//  ProfileRequest.swift
//  Habit
//
//  Created by Jamerson Macedo on 04/07/24.
//

import Foundation
struct ProfileResponse: Decodable{ // decodable pq vai receber um json
    let id:Int
    let fullName:String
    let email:String
    let document:String
    let phone:String
    let gender:Int
    let birthday:String
    
    enum CodingKeys : String,CodingKey{
        case id
        case fullName = "name"
        case email
        case document
        case phone
        case gender
        case birthday
    
    
    }
    
}
