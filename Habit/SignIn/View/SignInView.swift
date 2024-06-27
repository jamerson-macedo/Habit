//
//  SignInView.swift
//  Habit
//
//  Created by Jamerson Macedo on 27/06/24.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel : SignInViewModel
    
    var body: some View {
        Text("Tela de Login")
    }
}

#Preview {
    SignInView(viewModel: SignInViewModel())
}
