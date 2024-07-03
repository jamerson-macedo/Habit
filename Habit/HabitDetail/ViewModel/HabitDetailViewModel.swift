//
//  HabitDetailViewModel.swift
//  Habit
//
//  Created by Jamerson Macedo on 03/07/24.
//

import Foundation
import Combine
import SwiftUI

class HabitDetailViewModel :ObservableObject{
    @Published var uiState : HabitDetailUiState = .none
    @Published var value = ""
    
    let id: Int
    let name : String
    let label :String
    
    init(id: Int, name: String, label: String) {
        self.id = id
        self.name = name
        self.label = label
    }
}
