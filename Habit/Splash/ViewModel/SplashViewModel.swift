//
//  SplashViewModel.swift
//  Habit
//
//  Created by Jamerson Macedo on 26/06/24.
//

import Foundation
import SwiftUI

class SplashViewModel : ObservableObject {
    // definindo o tipo que ira iniciar o app
    @Published var uiState:SplashUiState = .loading
    
    func onAppear(){
        // faz alfo assicrono e muda o estado dps da resposta da uiState
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
            // aqui dfaz dps de 2 segundos
            // me retornou a tela de signin
            self.uiState = .goToSignInScreen
            
        })
    }
    
}

extension SplashViewModel{
    func signInView() -> some View{
        return SplashViewRouter.makeSignView()
    }
}
