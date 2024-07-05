//
//  HomeViewModel.swift
//  Habit
//
//  Created by Jamerson Macedo on 27/06/24.
//

import SwiftUI
class HomeViewModel : ObservableObject{
    let viewModel = HabitViewModel(interactor: HabitInteractor())
    let profileViewModel = ProfileViewModel()
    
}
extension HomeViewModel {
    func habitView() -> some View{
        return HomeViewRouter.makeHabitView(viewModel: viewModel)
    }
    func profileView() ->some View{
        return HomeViewRouter.makeProfileView(viewModel: profileViewModel)
    }
    
}
