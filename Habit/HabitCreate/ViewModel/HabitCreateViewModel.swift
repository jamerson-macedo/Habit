//
//  HabitCreateViewModel.swift
//  Habit
//
//  Created by Jamerson Macedo on 09/07/24.
//

import Foundation
import Combine
import SwiftUI
class HabitCreateViewModel: ObservableObject {
  
  @Published var uiState: HabitDetailUiState = .none
  @Published var name = ""
  @Published var label = ""
  
  @Published var image: Image? = Image(systemName: "camera.fill")
  
  @Published var imageData: Data? = nil
  
  private var cancellable: AnyCancellable?
  var cancellables = Set<AnyCancellable>()
  var habitPublisher: PassthroughSubject<Bool, Never>?
  
  let interactor: HabitCreateInteractor
  
  init(interactor: HabitCreateInteractor) {
    self.interactor = interactor
  }
  
  deinit {
    cancellable?.cancel()
    for cancellable in cancellables {
      cancellable.cancel()
    }
  }
  
  func save() {
    self.uiState = .loading
    
    cancellable = interactor.save(request: HabitCreateRequest(imageData: imageData,
                                                                         name: name,
                                                                         label: label))
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { completion in
        switch(completion) {
          case .failure(let appError):
            self.uiState = .error(appError.message ?? "erro")
            break
          case .finished:
            break
        }
      }, receiveValue: {
        self.uiState = .success
        self.habitPublisher?.send(true)
      })
  }
  
}
