//
//  ErrorResponse.swift
//  Habit
//
//  Created by Jamerson Macedo on 30/06/24.
//

import Foundation
struct ErrorResponse :Decodable{
    let detail :String
    enum CodingKeys :String, CodingKey{
        case detail
    }
}
