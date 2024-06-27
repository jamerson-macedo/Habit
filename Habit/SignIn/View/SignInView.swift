//
//  SignInView.swift
//  Habit
//
//  Created by Jamerson Macedo on 27/06/24.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel : SignInViewModel
    @State var email = ""
    @State var passWord = ""
    
    @State var navigationHidden = true
    var body: some View {
        ZStack{
            // se o viewmodel for para a tela principal
            if case SignInUiState.goToHomeScreen = viewModel.uiState{
                viewModel.homeView()
            }else {
                NavigationStack{
                    ScrollView(showsIndicators: false ){
                        VStack(alignment:.center, spacing: 20){
                            Spacer(minLength: 36) // espaco em cima da logo
                            VStack(alignment: .center,spacing: 8){
                                Image("logo").resizable().scaledToFit().padding(.horizontal,48)
                                Text("Login").foregroundColor(Color.orange).font(Font.system(.title).bold())
                                    .padding(.bottom,8)
                                emailField
                                passWordField
                                enterButton
                                registerLink
                                Text("Copyright @yyy").foregroundColor(.gray).font(Font.system(size: 16).bold()).padding(.top,16)
                            }
                            
                        }
                        if case SignInUiState.error(let value) = viewModel.uiState{
                            Text("")
                                .alert(isPresented: .constant(true)){
                                    Alert(title: Text("Habit"), message: Text(value),dismissButton: .default(Text("Ok")))
                                }
                        }
                        
                    }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
                        .padding(.horizontal,32)
                        .background(Color.white)
                        .navigationBarTitle("Login", displayMode:.inline)
                        .navigationBarHidden(navigationHidden)
                }
            }
        }
        
    }
}


extension SignInView {
    var emailField: some View{
        TextField("",text: $email).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
    }
}
extension SignInView {
    var passWordField: some View{
        SecureField("",text: $passWord).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
    }
}
extension SignInView {
    var enterButton: some View{
        Button("Entrar",action: {
            viewModel.login(email: email, password:passWord)
        })
    }
}
extension SignInView {
    var registerLink: some View{
        VStack{
            Text("Ainda não possui login ativo?").foregroundColor(.gray).padding(.top,48)
            ZStack{
                NavigationLink() {
                    viewModel.signUpView()
                } label: {
                    Text("Realize seu cadastro")
                }
                
            }
        }
        
    }
}


struct SignInView_Preview : PreviewProvider{
    static var previews: some View{
        let viewModel = SignInViewModel()
        SignInView(viewModel:viewModel)
    }
}
