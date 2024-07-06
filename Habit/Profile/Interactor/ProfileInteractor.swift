//
//  ProfileInteractor.swift
//  Habit
//
//  Created by Jamerson Macedo on 04/07/24.
//

import Foundation
import Combine
class ProfileInteractor{
    private let remote : ProfileRemoteDataSource = .shared
}

extension ProfileInteractor{
    func fetchUser()->Future<ProfileResponse,AppError>{
        remote.fetchUser()
    }
    func updateUser(id:Int,profileRequest:ProfileRequest)->Future<ProfileResponse,AppError>{
        return remote.updateUser(id: id, profileRequest: profileRequest)
        
    }
}
