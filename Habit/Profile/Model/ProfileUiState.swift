//
//  ProfileUiState.swift
//  Habit
//
//  Created by Jamerson Macedo on 04/07/24.
//

import Foundation
enum ProfileUiState:Equatable{
    case none
    case loading
    case fetchSuccess
    case fetchError(String)
    
    
    case updateLoading
    case updateSuccess
    case updateError(String)
}
