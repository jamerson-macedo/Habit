//
//  SplashUiState.swift
//  Habit
//
//  Created by Jamerson Macedo on 26/06/24.
//

import Foundation
// ESTADOS QUE A TELA PODE ESTAR
enum SplashUiState{
    case loading
    case goToSignInScreen
    case goToHomeScreen
    case error(String)
    
}
