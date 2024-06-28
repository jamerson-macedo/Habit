//
//  SignUpView.swift
//  Habit
//
//  Created by Jamerson Macedo on 27/06/24.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel :SignUpViewModel
    
    @State var fullName = ""
    @State var email = ""
    @State var passWord = ""
    @State var document = ""
    @State var phone = ""
    @State var birthday = ""
    @State var gender = Gender.male // comecar como masculino
    
    var body: some View {
        ZStack{
            ScrollView(showsIndicators:false){
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                    // leading é igual a right
                    VStack(alignment: .leading,spacing: 8) {
                        Text("Cadastro").foregroundStyle(.black)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold()
                            .padding(.bottom,8)
                        fullNameField
                        emailField
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
        TextField("", text: $fullName).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
    }
}
extension SignUpView{
    var emailField : some View{
        TextField("", text: $email).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
    }
}
extension SignUpView{
    var passwordField : some View{
        TextField("", text: $passWord).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
    }
}
extension SignUpView{
    var documentField : some View{
        TextField("", text: $document).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
    }
}
extension SignUpView{
    var genderField: some View{
        Picker("Gender", selection: $gender){
            // o propio elemento é seu identificador self
            ForEach(Gender.allCases, id: \.self){ value in
                Text(value.rawValue).tag(value)
            }
        }.pickerStyle(SegmentedPickerStyle()).padding(.top, 16).padding(.bottom,32)
    }
}
extension SignUpView{
    var phoneField : some View{
        TextField("", text: $phone).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
    }
}
extension SignUpView{
    var birthDayField : some View{
        TextField("", text: $birthday).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
    }
}
extension SignUpView{
    var enterButton : some View{
        Button("Realize o cadastro"){
            viewModel.signUp()
        }
    }
}
#Preview {
    SignUpView(viewModel: SignUpViewModel())
}
