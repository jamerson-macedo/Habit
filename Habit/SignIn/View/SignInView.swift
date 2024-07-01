//
//  SignInView.swift
//  Habit
//
//  Created by Jamerson Macedo on 27/06/24.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel : SignInViewModel
   
    
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
                                Text("Copyright - Jamerson Macedo 1996").foregroundColor(.gray).font(Font.system(size: 13).bold()).padding(.top,16)
                            }
                            
                        }
                        if case SignInUiState.error(let value) = viewModel.uiState{
                            Text("")
                                .alert(isPresented: .constant(true)){
                                    Alert(title: Text("Habit"), message: Text(value),dismissButton: .default(Text("Ok")))
                                }
                        }
                        
                    }.frame(maxWidth: .infinity,maxHeight: .infinity)
                        .padding(.horizontal,32)
                        .navigationBarTitle("Login", displayMode:.inline)
                        .navigationBarHidden(navigationHidden)
                }
                .onAppear{
                    self.navigationHidden = true
                }
                .onDisappear{
                    self.navigationHidden = false
                }
            }
        }
        
    }
}


extension SignInView {
    var emailField: some View{
        //TextField("",text: $email).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
        EditTextView( placeholder: "E-mail", error: "Email Invalido", failure: !viewModel.email.isEmail(), keyboard: .emailAddress, text: $viewModel.email)
    }
}
extension SignInView {
    var passWordField: some View{
        EditTextView(placeholder: "Senha", error: "Senha deve ter 8 caracteres", failure: viewModel.passWord.count < 8, keyboard: .emailAddress, isSecure: true, text: $viewModel.passWord)
    }
}
extension SignInView {
    var enterButton: some View{
        LoadingButtonView(action: {
            viewModel.login()
        }, disabled: !viewModel.email.isEmail() || viewModel.passWord.count < 8, showProgress: self.viewModel.uiState == SignInUiState.loading, text: "Entrar")
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


#Preview("Light") {
    SignInView(viewModel: SignInViewModel(interactor: SignInInteractor())).preferredColorScheme(.light)
}
#Preview("Dark") {
    SignInView(viewModel:SignInViewModel(interactor: SignInInteractor())).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    
}
