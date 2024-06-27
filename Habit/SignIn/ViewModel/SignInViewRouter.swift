//
//  SignInViewRouter.swift
//  Habit
//
//  Created by Jamerson Macedo on 27/06/24.
//

import SwiftUI
enum SignInViewRouter{
    static func makeHomeView() -> some View{
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
        
    }
    static func makeSignUpView() -> some View{
        return SignUpView()
    }
    
}
