//
//  SignUpUiState.swift
//  Habit
//
//  Created by Jamerson Macedo on 28/06/24.
//

import Foundation
enum SignUpUiState : Equatable{
    case loading
    case none
    case error(String)
    case success
}
