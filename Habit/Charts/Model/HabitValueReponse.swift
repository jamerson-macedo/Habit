//
//  HabitValueReponse.swift
//  Habit
//
//  Created by Jamerson Macedo on 09/07/24.
//

import Foundation
struct HabitValueReponse :Decodable{
    // valores que a api retorna
    let id :Int
    let value : Int
    let habitid :Int
    let createdDate : String
    
    enum CodingKeys:String, CodingKey{
         case id
        case value
        case habitid = "habit_id"
        case createdDate = "created_Date"
    }
    
}

