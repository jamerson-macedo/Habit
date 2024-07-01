//
//  HabitApp.swift
//  Habit
//
//  Created by Jamerson Macedo on 26/06/24.
//

import SwiftUI

@main
struct HabitApp: App {
    var body: some Scene {
        WindowGroup {
           SplashView(viewModel: SplashViewModel(interactor: SplashInteractor()))
        }
    }
}
