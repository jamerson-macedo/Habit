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
    
}

extension SplashInteractor{
    func fetchAuth() -> Future<UserAuth?,Never>{
        return local.getUserAuth()
    }
    
}
