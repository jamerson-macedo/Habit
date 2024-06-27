//
//  SignUpView.swift
//  Habit
//
//  Created by Jamerson Macedo on 27/06/24.
//

import SwiftUI

struct SignUpView: View {
    
    @State var fullName = ""
    @State var email = ""
    @State var passWord = ""
    @State var document = ""
    @State var phone = ""
    @State var birthday = ""
    // @State var genere = ""
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
                        enterButton
                    }
                    Spacer() // empurra para cima
                }.padding(.horizontal,8)
            }.padding()
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
            // viewModel
        }
    }
}
#Preview {
    SignUpView()
}
