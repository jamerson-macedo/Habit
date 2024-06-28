//
//  SignInUiState.swift
//  Habit
//
//  Created by Jamerson Macedo on 27/06/24.
//

import Foundation
enum SignInUiState : Equatable{ // PARA PODER COMPARAR TEM QUE COLOCAR EQUATABLE
    case none // estado parado
    case loading
    case goToHomeScreen
    case error(String)
}
