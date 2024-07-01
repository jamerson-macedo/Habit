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
    private var cancellableRequest : AnyCancellable?
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
        cancellableRequest?.cancel()
    }
    
    func login(){
        self.uiState = .loading
       cancellableRequest = interactor.login(request: SignInRequest(email: self.email, password: self.passWord))
            .receive(on: DispatchQueue.main)
            .sink { completion in
            // aqui aconece o ERROR OU o FINISHED
            switch(completion){
            case .failure(let appError):
                self.uiState = SignInUiState.error(appError.message ?? "Erro desconhecido")
                break
            case .finished:
                break
            }
        } receiveValue: { success in
            print(success)
            self.uiState = .goToHomeScreen
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

