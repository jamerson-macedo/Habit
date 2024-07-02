//
//  HabitViewModel.swift
//  Habit
//
//  Created by Jamerson Macedo on 02/07/24.
//

import Foundation
class HabitViewModel :ObservableObject{
    @Published var uiState : HabitUIState = .emptyList
    @Published var title = "Atenção"
    @Published var headline = "Fique ligado!"
    @Published var desc = "Voce esta atrasado nos hábitos"
    
}
