//
//  HabitCreateViewModel.swift
//  Habit
//
//  Created by Jamerson Macedo on 09/07/24.
//

import Foundation
import Combine
import SwiftUI
class HabitCreateViewModel : ObservableObject{
    @Published var uiState : HabitDetailUiState = .none
    @Published var name = ""
    @Published var label = ""
    private var cancellable :AnyCancellable?
    
    var cancellables = Set<AnyCancellable>()
    var habitPublisher : PassthroughSubject<Bool,Never>?
   
    let interactor:HabitDetailInteractor
    init(interactor:HabitDetailInteractor) {
    
        self.interactor=interactor
    }
    deinit{
        cancellable?.cancel()
        for cancellable in cancellables{
            cancellable.cancel()
        }
    }
    
    func save(){
        self.uiState = .loading
    }
}


