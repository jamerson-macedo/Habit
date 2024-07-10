//
//  HabitCreateRequest.swift
//  Habit
//
//  Created by Jamerson Macedo on 10/07/24.
//

import Foundation
// não é json entao nao presisa ser encodable
struct HabitCreateRequest {
    let imageData : Data?
    let name: String
    let label : String
    
}
