//
//  SignUpViewModel.swift
//  Habit
//
//  Created by Jamerson Macedo on 28/06/24.
//

import Foundation
import SwiftUI
import Combine
class SignUpViewModel :ObservableObject{
    @Published var uiState :SignUpUiState = .none
    var publisher : PassthroughSubject<Bool,Never>!
    
    
    func signUp(){
        self.uiState = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
           // self.uiState = .error("falha no login")
            self.uiState = .success
            self.publisher.send(true)
        }
    }
}

extension SignUpViewModel {
    func homeView() -> some View{
        return SignUpViewRouter.makeViewHome()
    }
}
