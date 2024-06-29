//
//  SplashView.swift
//  Habit
//
//  Created by Jamerson Macedo on 26/06/24.
//

import SwiftUI

struct SplashView: View {
    @ObservedObject var viewModel : SplashViewModel
   
    var body: some View {
        Group{
            switch viewModel.uiState {
            case .loading:
                loadingView()
            case .goToSignInScreen:
                viewModel.signInView()
            case .goToHomeScreen:
                Text("Home")
            case .error(let msg):
                loadingView(error: msg)
            }
        }.onAppear(perform: {
            viewModel.onAppear()
        }) // toda vez que a tela aparecer  ele executa
    }
}

extension SplashView {
    func loadingView(error:String? = nil) -> some View{
        ZStack{
            Image("logo").resizable().scaledToFit().frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                .padding(20)
                .ignoresSafeArea()
            
            if let error = error{
                Text("")
                    .alert(isPresented: .constant(true), content: {
                        Alert(title: Text("Habit"), message: Text(error),dismissButton: .default(Text("Ok"), action: {
                            // faz alguma coisa
                    }))
                })
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SplashViewModel()
        SplashView(viewModel: viewModel).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
