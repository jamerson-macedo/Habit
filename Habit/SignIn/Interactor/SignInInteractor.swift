//
//  SignInInteractor.swift
//  Habit
//
//  Created by Jamerson Macedo on 01/07/24.
//

import Foundation
import Combine
// funciona como se fosse um repositorio
// decide se vai vir da web ou do local

class SignInInteractor {
    
    private let remote : SignInRemoteDataSource = .shared
    private let local: LocalDataSource = .shared

    
}

extension SignInInteractor {
    func login(request :SignInRequest)->Future<SignInResponse,AppError>{
        return remote.login(request: request)
    }
    func insertAuth(userAuth:UserAuth){
        local.insertUserAuth(userAuth: userAuth)
    }
}
