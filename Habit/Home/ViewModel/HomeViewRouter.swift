//
//  HomeViewRouter.swift
//  Habit
//
//  Created by Jamerson Macedo on 02/07/24.
//

import Foundation
import SwiftUI
enum HomeViewRouter {
    static func makeHabitView(viewModel:HabitViewModel)->some View{

        return HabitView(viewModel:viewModel)
    }
    static func makeProfileView(viewModel:ProfileViewModel) ->some View{
        return ProfileView(viewModel: viewModel)
    }
}
