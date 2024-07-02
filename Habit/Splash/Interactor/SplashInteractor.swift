//
//  SplashInteractor.swift
//  Habit
//
//  Created by Jamerson Macedo on 01/07/24.
//

import Foundation
import Combine

class SplashInteractor {
    private let local : LocalDataSource = .shared
    private let remote : SplashRemoteDataSource = .shared
    
}

extension SplashInteractor{
    func fetchAuth() -> Future<UserAuth?,Never>{
        return local.getUserAuth()
    }
    func refreshToken(request :RefreshRequest) ->Future<SignInResponse,AppError>{
       return remote.refreshToken(request: request)
        
        
    }
    func insertAuth(userAuth:UserAuth){
        local.insertUserAuth(userAuth: userAuth)
    }
    
}
