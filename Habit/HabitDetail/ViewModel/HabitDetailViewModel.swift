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
    private var cancellable :AnyCancellable?
    let id: Int
    let name : String
    let label :String
    let interactor:HabitDetailInteractor
    init(id: Int, name: String, label: String,interactor:HabitDetailInteractor) {
        self.id = id
        self.name = name
        self.label = label
        self.interactor=interactor
    }
    deinit{
        cancellable?.cancel()
    }
    
    func save(){
        self.uiState = .loading
        cancellable = interactor.save(habitId: id, request: HabitValueRequest(value: value)).subscribe(on: DispatchQueue.main).sink(receiveCompletion: { completion in
            switch(completion){
            case .failure(let error):
                self.uiState = .error(error.message ?? "Erro desconhecido")
                break
            case .finished:
                break
            }
        }, receiveValue: { created in
            if(created){
                self.uiState = .success
            }
        })
    }
}
