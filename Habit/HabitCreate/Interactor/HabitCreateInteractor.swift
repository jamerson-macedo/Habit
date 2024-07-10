//
//  HabitCreateInteractor.swift
//  Habit
//
//  Created by Jamerson Macedo on 10/07/24.
//

import Foundation
import Combine
class HabitCreateInteractor {
    
    private let remote : HabitCreateDataSource = .shared
   

    
}

extension HabitCreateInteractor {
    func save(request :HabitCreateRequest)->Future<Void,AppError>{
        remote.save(request: request)
    }
}
