//
//  SplashViewModel.swift
//  Habit
//
//  Created by Jamerson Macedo on 26/06/24.
//

import Foundation
import SwiftUI
import Combine
class SplashViewModel : ObservableObject {
    // definindo o tipo que ira iniciar o app
    @Published var uiState:SplashUiState = .loading
    
    private var cancellableAuth : AnyCancellable?
    private var cancellableRefresh : AnyCancellable?
    
    private let interactor : SplashInteractor
    // preparando para receber
    init(interactor :SplashInteractor){
        self.interactor = interactor
    }
    // quando o objeto morrer
    deinit{
        cancellableAuth?.cancel() // desligar a chamada
        cancellableRefresh?.cancel()
    }
    
    func onAppear(){
        cancellableAuth = interactor.fetchAuth()
            .receive(on: DispatchQueue.main)
            .sink { userAuth in
                // se não tiver usuario
                if userAuth == nil{
                    self.uiState = .goToSignInScreen
                }
                // se tiver e ja for expirado
                else if (Date().timeIntervalSince1970 > Double(userAuth!.expires)){
                    // chamar refresh na api
                    print("Token expirou")
                    let request = RefreshRequest(token: userAuth!.refreshToken)
                    self.cancellableRefresh = self.interactor.refreshToken(request:request)
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: { completion in
                            switch(completion){
                            case .failure(_):
                                self.uiState = .goToSignInScreen
                                break
                            default:
                                break
                            }
                        }, receiveValue: { success in
                            
                            let dateActual = Date().timeIntervalSince1970
                            // registrando o token
                            let auth = UserAuth(idToken:success.accessToken, refreshToken: success.refreshToken, expires: dateActual+Double(success.expires), tokenType: success.tokenType)
                            
                            self.interactor.insertAuth(userAuth:auth)
                            self.uiState = .goToHomeScreen
                            
                        })
                }
                // se tiver ok
                else {
                    self.uiState = .goToHomeScreen
                }
            }
    }
    
}

extension SplashViewModel{
    func signInView() -> some View{
        return SplashViewRouter.makeSignView()
    }
    func homeView() -> some View {
        return SplashViewRouter.makeHomeView()
    }
}

