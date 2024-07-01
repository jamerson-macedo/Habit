//
//  SignInInteractor.swift
//  Habit
//
//  Created by Jamerson Macedo on 01/07/24.
//

import Foundation
// funciona como se fosse um repositorio
// decide se vai vir da web ou do local

class SignInInteractor {
    private let remote : RemoteDataSource = .shared

    
}

extension SignInInteractor {
    func login(request :SignInRequest, completion :@escaping (SignInResponse?,SignInError?)->Void){
        remote.login(request: request, completion: completion)
        
    }
}
