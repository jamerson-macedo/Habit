//
//  SignInViewModel.swift
//  Habit
//
//  Created by Jamerson Macedo on 27/06/24.
//


import SwiftUI
import Combine
class SignInViewModel : ObservableObject{
    
    @Published var email = ""
    @Published var passWord = ""
    
    private var cancellable : AnyCancellable?
    private let publisher = PassthroughSubject<Bool, Never>()
    
    @Published var uiState: SignInUiState = .none
    private let interactor : SignInInteractor
    // preparando para receber
    init(interactor :SignInInteractor){
        self.interactor = interactor
        cancellable = publisher.sink{ value in
            print("Usuario criado : \(value)")
            if(value){
                self.uiState = .goToHomeScreen // atualiza o estado
            }
        }
    }
    // quando o objeto morrer
    deinit{
        cancellable?.cancel() // desligar a chamada
    }
    
    func login(){
        self.uiState = .loading
       interactor.login(request: SignInRequest(email: self.email, password: self.passWord)){ successResponse,errorResponse in
            if let error = errorResponse{
                DispatchQueue.main.async {
                    // delega para a main
                    self.uiState = .error(error.detail.message) // passando para ui o erro do login
                    
                }
            }
            if let success = successResponse{
                DispatchQueue.main.async {
                    print(success)
                    self.uiState = .goToHomeScreen
                }
            }
        }
        
    }
}
    
    extension SignInViewModel{
        func homeView() -> some View{
            return SignInViewRouter.makeHomeView()
        }
        func signUpView() ->some View {
            return SignInViewRouter.makeSignUpView(publisher: publisher)
        }
    }

