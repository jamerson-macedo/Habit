//
//  ChartInteractor.swift
//  Habit
//
//  Created by Jamerson Macedo on 09/07/24.
//

import Foundation
import Combine
class ChartInteractor {
    private let remote : ChartRemoteDataSource = .shared
}

extension ChartInteractor{
    func fetchHabiValues(habitId:Int) -> Future<[HabitValueReponse],AppError>{
        remote.fetchHabiValues(habitId: habitId)
    }
}
