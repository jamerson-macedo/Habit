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
        
        
        WebService.postUser(request: SignUpRequest(fullName: fullName, email: email, document: document, phone: phone, gender: gender.index, birthday: birthday, password: passWord))
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
//           // self.uiState = .error("falha no login")
//            self.uiState = .success
//            self.publisher.send(true)
//        }
    }
}

extension SignUpViewModel {
    func homeView() -> some View{
        return SignUpViewRouter.makeViewHome()
    }
}
