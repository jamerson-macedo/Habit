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
    
    @Published var fullName = ""
    @Published var email = ""
    @Published var passWord = ""
    @Published var document = ""
    @Published var phone = ""
    @Published var birthday = ""
    @Published var gender = Gender.male // comecar como masculino
    
    @Published var uiState :SignUpUiState = .none
    
    var publisher : PassthroughSubject<Bool,Never>!
    private var cancellableSignUp :AnyCancellable?
    private var cancellableSignIn :AnyCancellable?
    
    
    private var interactor:SignUpInteractor
    
    
    init(interactor:SignUpInteractor){
        self.interactor = interactor
    }
    deinit{
        cancellableSignUp?.cancel()
        cancellableSignIn?.cancel()
    }
    
    func signUp(){
        self.uiState = .loading
        // pegar a string -> dd/MM/yyyy ->
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatted = formatter.date(from: birthday)
        // validar a data
        guard let dateFormatted = dateFormatted else {
            self.uiState = .error("Data Invalida \(birthday)")
            return
        }
        // convertendo para o objeto
        formatter.dateFormat = "yyyy-MM-dd"
        let birthday = formatter.string(from: dateFormatted)
        
        // criando o objeto
        let signUpRequest = SignUpRequest(fullName: fullName, email: email, document: document, phone: phone, gender: gender.index, birthday: birthday, password: passWord)
        
        
       cancellableSignUp = interactor.postUser(request: signUpRequest)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch(completion){
                case .failure(let appError):
                    self.uiState = .error(appError.message ?? "Erro desconhecido")
                    break
                case .finished:
                    break
                    
                }
            } receiveValue: { success in
                if(success){
                    self.cancellableSignIn = self.interactor.login(request: SignInRequest(email: self.email, password: self.passWord))
                        .receive(on: DispatchQueue.main)
                        .sink { completion in
                            switch(completion){
                            case .failure(let appError):
                                self.uiState = .error(appError.message ?? "Erro desconhecido")
                                break
                            case .finished:
                                break
                            }
                        } receiveValue: { successSignIn in
                            print(success)
                            self.publisher.send(success)
                            self.uiState = .success
                        }
                    
                }
                
            }
    }
}

extension SignUpViewModel {
    func homeView() -> some View{
        return SignUpViewRouter.makeViewHome()
    }
}
