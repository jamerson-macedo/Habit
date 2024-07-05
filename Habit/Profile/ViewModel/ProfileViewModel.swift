//
//  ProfileViewModel.swift
//  Habit
//
//  Created by Jamerson Macedo on 04/07/24.
//

import Foundation
import Combine
class ProfileViewModel: ObservableObject{
    
    @Published var uiState : ProfileUiState = .none
    
    // referencia da classe
    @Published var fullNameValidation = FullNameValidation()
    @Published var phoneValidation = PhoneValidation()
    @Published var birthdayValidation = BirthdayValidation()
    var userId:Int? // vai vim na requisição
    @Published var email = ""
    @Published var document = ""
    @Published var gender:Gender?
    
    private var cancellable :AnyCancellable?
    
    private var interactor : ProfileInteractor
    init(interactor:ProfileInteractor){
        self.interactor=interactor
    }
    deinit{
        cancellable?.cancel()
    }
    
    
    func fetchUser(){
        self.uiState = .loading
        cancellable = interactor.fetchUser().receive(on: DispatchQueue.main).sink(receiveCompletion: { completion in
            switch(completion){
            case .failure(let appError):
                self.uiState = .fetchError(appError.message ?? "Erro desconhecido")
                break
            case .finished:
                break

                
            }
        }, receiveValue: { response in
            self.userId = response.id // guardando o id que ta vindo
            self.email = response.email
            self.document = response.document
            self.gender = Gender.allCases[response.gender]
            self.fullNameValidation.value = response.fullName
            self.phoneValidation.value = response.phone
        // formatnado a data
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-MM-dd"
            let dateFormatted = formatter.date(from: response.birthday)
            guard let dateFormatted = dateFormatted else {
                self.uiState = .fetchError("Data invalida \(response.birthday)")
                return
            }
            formatter.dateFormat = "dd/MM/yyyy"
            let birthday = formatter.string(from: dateFormatted)
            self.birthdayValidation.value = birthday
            self.uiState = .fetchSuccess
            
        })
    }
}




class FullNameValidation:ObservableObject{
    @Published var failure = false
    var value :String = ""{
        didSet{
            failure = value.count<3
        }
    }
}

class PhoneValidation : ObservableObject{
    @Published var failure = false
    var value : String = ""{
        didSet{
            failure = value.count < 10 || value.count >= 12
        }
    }
}
class BirthdayValidation : ObservableObject{
    @Published var failure = false
    var value : String = ""{
        didSet{
            failure = value.count != 10
        }
    }
}
