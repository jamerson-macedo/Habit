//
//  HabitCardViewRouter.swift
//  Habit
//
//  Created by Jamerson Macedo on 03/07/24.
//

import Foundation
import SwiftUI
enum HabitCardViewRouter{
    static func makeHabitDetailView(id:Int,name:String,label :String) -> some View{
        let viewModel = HabitDetailViewModel(id: id, name: name, label: label,interactor: HabitDetailInteractor())
        return HabitDetailView(viewModel: viewModel)
    }
}
