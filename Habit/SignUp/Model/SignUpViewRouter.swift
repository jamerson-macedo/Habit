//
//  SignUpViewRouter.swift
//  Habit
//
//  Created by Jamerson Macedo on 28/06/24.
//

import SwiftUI
import Combine
enum SignUpViewRouter {
    static func makeViewHome () -> some View{
        
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
}
