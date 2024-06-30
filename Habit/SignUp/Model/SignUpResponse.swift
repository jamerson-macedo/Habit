//
//  SignUpResponse.swift
//  Habit
//
//  Created by Jamerson Macedo on 30/06/24.
//

import Foundation
struct SignUpResponse :Decodable{
    let detail:String?
    enum CodingKeys : String,CodingKey{
        case detail
    }
}
