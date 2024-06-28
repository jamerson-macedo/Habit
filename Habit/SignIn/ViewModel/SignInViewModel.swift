//
//  SignInViewModel.swift
//  Habit
//
//  Created by Jamerson Macedo on 27/06/24.
//


import SwiftUI
import Combine
class SignInViewModel : ObservableObject{
    private var cancellable : AnyCancellable?
    private let publisher = PassthroughSubject<Bool, Never>()
    
    @Published var uiState: SignInUiState = .none
    // preparando para receber
    init(){
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
    
    func login(email:String, password:String){
        self.uiState = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            self.uiState = .error("uSUARIO NAO ENCONTRADO")
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

