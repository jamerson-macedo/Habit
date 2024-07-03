//
//  HabitDetailInteractor.swift
//  Habit
//
//  Created by Jamerson Macedo on 03/07/24.
//

import Foundation
import Combine
class HabitDetailInteractor{
    
    private let remote : HabitDetailRemoteDataSource = .shared
    
}


extension HabitDetailInteractor {
    func save(habitId:Int,request :HabitValueRequest)->Future<Bool,AppError>{
        return remote.save(habitId: habitId, request: request)
    }
   
}

