//
//  SignUpInteractor.swift
//  Habit
//
//  Created by Jamerson Macedo on 01/07/24.
//

import Foundation
import Combine
class SignUpInteractor{
    private let remoteSignUp : SignUpRemoteDataSource = .shared
    private let remoteSignIn : SignInRemoteDataSource = .shared
    private let local :LocalDataSource = .shared
    
}


extension SignUpInteractor {
    func postUser(request :SignUpRequest)->Future<Bool,AppError>{
        return remoteSignUp.postUser(request: request)
    }
    func login(request :SignInRequest)->Future<SignInResponse,AppError>{
        return remoteSignIn.login(request: request)
    }
    func insertAuth(userAuth:UserAuth){
        local.insertUserAuth(userAuth: userAuth)
    }
}
