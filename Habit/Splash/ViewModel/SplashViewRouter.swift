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
        let viewModel = SignInViewModel(interactor: SignInInteractor())
        return SignInView(viewModel: viewModel)
    }
}
