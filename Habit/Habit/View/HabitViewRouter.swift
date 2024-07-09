//
//  HabitViewRouter.swift
//  Habit
//
//  Created by Jamerson Macedo on 09/07/24.
//

import Foundation
import Combine
import SwiftUI
enum HabitViewRouter {
    static func makeHabitCreate(habitPublisher :PassthroughSubject<Bool,Never>)->some View{
        let viewModel = HabitCreateViewModel(interactor: HabitDetailInteractor())
        viewModel.habitPublisher = habitPublisher
        return HabitCreateView(viewModel: viewModel)
    }
}
