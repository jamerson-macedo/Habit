//
//  SignInViewModel.swift
//  Habit
//
//  Created by Jamerson Macedo on 27/06/24.
//


import SwiftUI

class SignInViewModel : ObservableObject{
    
    @Published var uiState: SignInUiState = .none
    // comeca assim
    func login(email:String, password:String){
        self.uiState = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            self.uiState = .goToHomeScreen
        }
    }
    
    
}

extension SignInViewModel{
    func homeView() -> some View{
        return SignInViewRouter.makeHomeView()
    }
    func signUpView() ->some View {
        return SignInViewRouter.makeSignUpView()
    }
}

