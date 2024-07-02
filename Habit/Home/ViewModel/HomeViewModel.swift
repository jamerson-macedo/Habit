//
//  HomeViewModel.swift
//  Habit
//
//  Created by Jamerson Macedo on 27/06/24.
//

import SwiftUI
class HomeViewModel : ObservableObject{
    
}
extension HomeViewModel {
    func habitView() -> some View{
        return HomeViewRouter.makeHabitView()
    }
    
}
