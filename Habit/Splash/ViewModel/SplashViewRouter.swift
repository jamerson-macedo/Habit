//
//  SplashViewRouter.swift
//  Habit
//
//  Created by Jamerson Macedo on 27/06/24.
//

import SwiftUI

enum SplashViewRouter {
    // tipo o object do kotlin
    static func makeSignView() -> some View{
        
        let homeViewModel = HomeViewModel() // DEIXANDO PREPARADO
        let viewModel = SignInViewModel(interactor: SignInInteractor(),homeviewModel:homeViewModel)
        return SignInView(viewModel: viewModel)
    }
    static func makeHomeView()->some View{
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
}
