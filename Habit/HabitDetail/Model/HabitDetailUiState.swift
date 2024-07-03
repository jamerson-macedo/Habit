//
//  HabitDetailUiState.swift
//  Habit
//
//  Created by Jamerson Macedo on 03/07/24.
//

import Foundation
enum HabitDetailUiState:Equatable{
    case none
    case loading
    case success
    case error(String)
}
