//
//  ChartViewModel.swift
//  Habit
//
//  Created by Jamerson Macedo on 09/07/24.
//

import Foundation
import SwiftUI
import Combine
import Charts
class ChartViewModel : ObservableObject{
    
    @Published var uiState :ChartUiState = .loading
    @Published var entries: [ChartDataEntry] = []
    @Published var dates : [String] = []
    private let habitId :Int
    private var cancellable : AnyCancellable?
    private let interactor : ChartInteractor
    init(habitId:Int,interactor:ChartInteractor){
        self.habitId = habitId
        self.interactor = interactor
    }
    deinit{
        cancellable?.cancel()
    }
    func onAppear(){
        cancellable = interactor.fetchHabiValues(habitId: habitId).receive(on: DispatchQueue.main).sink(receiveCompletion: { completion in
            switch(completion){
            case .failure(let error):
                self.uiState = .error(error.message ?? "Erro desconhecido")
                break
            case .finished:
                break
            }
        }, receiveValue: {response in
        print(response)
            
        })
    }
    
}
