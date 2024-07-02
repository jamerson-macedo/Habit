//
//  HomeViewRouter.swift
//  Habit
//
//  Created by Jamerson Macedo on 02/07/24.
//

import Foundation
import SwiftUI
enum HomeViewRouter {
    static func makeHabitView()->some View{
        let viewModel = HabitViewModel()
        return HabitView(viewModel:viewModel)
    }
}
