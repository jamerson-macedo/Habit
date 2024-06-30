//
//  SignUpRequest.swift
//  Habit
//
//  Created by Jamerson Macedo on 30/06/24.
//

import Foundation
struct SignUpRequest: Encodable{ // encodable pq vai ser um json
    let fullName:String
    let email:String
    let document:String
    let phone:String
    let gender:Int
    let birthday:String
    let password:String
    
    enum CodingKeys : String,CodingKey{
        
    // mapeando os dados
        case fullName = "name"
        case email
        case document
        case phone
        case gender
        case birthday
        case password
    
    }
    
}
