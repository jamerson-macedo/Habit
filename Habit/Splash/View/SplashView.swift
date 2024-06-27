//
//  SplashView.swift
//  Habit
//
//  Created by Jamerson Macedo on 26/06/24.
//

import SwiftUI

struct SplashView: View {
    // definindo o tipo que ira iniciar o app
    @State var state:SplashUiState = .loading
    
    var body: some View {
        switch state{
        case .loading:
            loadingView()
        case .goToSignInScreen:
            Text("SignIn")
        case .goToHomeScreen:
            Text("Home")
        case .error(let msg):
            loadingView(error: msg)
        }
    }
}

extension SplashView {
    func loadingView(error:String?=nil) -> some View{
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

#Preview {
    SplashView()
}
