//
//  SignUpViewModel.swift
//  Habit
//
//  Created by Jamerson Macedo on 28/06/24.
//

import Foundation
import SwiftUI

class SignUpViewModel :ObservableObject{
    @Published var uiState :SignUpUiState = .none
    
    func signUp(){
        self.uiState = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
           // self.uiState = .error("falha no login")
            self.uiState = .goToHomeScreen
        }
    }
}

extension SignUpViewModel {
    func homeView() -> some View{
        return SignInViewRouter.makeHomeView()
    }
}
