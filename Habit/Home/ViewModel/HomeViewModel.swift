//
//  HomeViewModel.swift
//  Habit
//
//  Created by Jamerson Macedo on 27/06/24.
//

import SwiftUI
class HomeViewModel : ObservableObject{
    let viewModel = HabitViewModel(isCharts: false, interactor: HabitInteractor())
    let habitForChartsViewModel = HabitViewModel(isCharts: true, interactor: HabitInteractor())
    let profileViewModel = ProfileViewModel(interactor: ProfileInteractor())
    
}
extension HomeViewModel {
    func habitView() -> some View{
        return HomeViewRouter.makeHabitView(viewModel: viewModel)
    }
    func profileView() ->some View{
        return HomeViewRouter.makeProfileView(viewModel: profileViewModel)
    }
    func chartView() ->some View{
        return HomeViewRouter.makeHabitView(viewModel: habitForChartsViewModel)
    }
    
    
}
