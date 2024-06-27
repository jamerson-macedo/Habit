//
//  SignInUiState.swift
//  Habit
//
//  Created by Jamerson Macedo on 27/06/24.
//

import Foundation
enum SignInUiState{
    case none // estado parado
    case loading
    case goToHomeScreen
    case error(String)
}
