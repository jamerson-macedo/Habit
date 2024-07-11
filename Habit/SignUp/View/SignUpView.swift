//
//  SignUpView.swift
//  Habit
//
//  Created by Jamerson Macedo on 27/06/24.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel :SignUpViewModel
    
    var body: some View {
        ZStack{
            ScrollView(showsIndicators:false){
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                    // leading é igual a right
                    VStack(alignment: .leading,spacing: 8) {
                        Text("Cadastro").foregroundStyle(Color("textColor"))
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold()
                            .padding(.bottom,8)
                        fullNameField
                        emailField
                        passwordField
                        documentField
                        phoneField
                        birthDayField
                        genderField
                        enterButton
                    }
                    Spacer() // empurra para cima
                }.padding(.horizontal,8)
            }.padding()
            if case SignUpUiState.error(let value) = viewModel.uiState{
                Text("")
                    .alert(isPresented: .constant(true)){
                        Alert(title: Text("Habit"), message: Text(value),dismissButton: .default(Text("Ok")){
                            // faz algo
                        })
                    }
            }
        }
    }
}
extension SignUpView{
    var fullNameField : some View{
        EditTextView(placeholder: "Nome Completo", error: "Nome invalido", failure: viewModel.fullName.count<3, keyboard: .default, autocapitalization: .words, text: $viewModel.fullName)
    }
}
extension SignUpView{
    var emailField : some View{
        EditTextView( placeholder: "E-mail", error: "Email Invalido", failure: !viewModel.email.isEmail(), keyboard: .emailAddress, text: $viewModel.email)
    }
}
extension SignUpView{
    var passwordField : some View{
        EditTextView(placeholder: "Senha", error: "Senha deve ter 8 caracteres", failure: viewModel.passWord.count<8, keyboard: .emailAddress, isSecure: true, text: $viewModel.passWord)
    }
}
extension SignUpView{
    var documentField : some View{
        EditTextView(placeholder: "CPF", error: "CPF invalido", failure: viewModel.document.count != 11, keyboard: .numberPad, isSecure: false, text: $viewModel.document)
    }
}
extension SignUpView{
    var genderField: some View{
        Picker("Gender", selection: $viewModel.gender){
            // o propio elemento é seu identificador self
            ForEach(Gender.allCases, id: \.self){ value in
                Text(value.rawValue).tag(value)
            }
        }.pickerStyle(SegmentedPickerStyle()).padding(.top, 16).padding(.bottom,32)
    }
}
extension SignUpView{
    var phoneField : some View{
        EditTextView(placeholder: "Telefone", error: "TEntre com o DDD + 8 ou 9 digitos", failure: viewModel.phone.count < 10 || viewModel.phone.count >= 12, keyboard: .numberPad, isSecure: false, text: $viewModel.phone)
        
    }
}
extension SignUpView{
    var birthDayField : some View{
        EditTextView(placeholder: "Data de Nascimento", error: "Data deve ser dd/MM/yyyy", failure: viewModel.birthday.count != 10, keyboard: .default, isSecure: false, text: $viewModel.birthday)
    }
}
extension SignUpView{
    var enterButton : some View{
        LoadingButtonView(action: {
            viewModel.signUp()
        }, disabled: !viewModel.email.isEmail() ||
                          viewModel.passWord.count < 8 ||
                          viewModel.fullName.count<3 ||
                          viewModel.document.count != 11 ||
                          viewModel.phone.count < 10 || viewModel.phone.count >= 12 ||
                          viewModel.birthday.count != 10, showProgress: self.viewModel.uiState == SignUpUiState.loading, text: "Realize Seu cadastro"
        )
    }
}
#Preview {
    SignUpView(viewModel: SignUpViewModel(interactor: SignUpInteractor()))
}
#Preview {
    SignUpView(viewModel: SignUpViewModel(interactor: SignUpInteractor())).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
