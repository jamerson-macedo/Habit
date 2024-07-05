//
//  ProfileViewModel.swift
//  Habit
//
//  Created by Jamerson Macedo on 04/07/24.
//

import Foundation
class ProfileViewModel: ObservableObject{
    // referencia da classe
    @Published var fullNameValidation = FullNameValidation()
    @Published var phoneValidation = PhoneValidation()
    @Published var birthdayValidation = BirthdayValidation()
    
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
