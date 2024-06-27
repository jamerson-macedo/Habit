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
    
    @State var action:Int? = 0
    @State var navigationHidden = true
    var body: some View {
        NavigationView{
            ScrollView(showsIndicators: false ){
                VStack(alignment:.center, spacing: 20){
                    Spacer(minLength: 36) // espaco em cima da logo
                    VStack(alignment: .center,spacing: 8){
                        Image("logo").resizable().scaledToFit().padding(.horizontal,48)
                            .background(Color.black)
                        Text("Login").foregroundColor(Color.orange).font(Font.system(.title).bold())
                            .padding(.bottom,8)
                        numberField
                        passWordField
                        enterButton
                        registerLink
                        Text("Copyright @yyy").foregroundColor(.gray).font(Font.system(size: 16).bold()).padding(.top,16)
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


extension SignInView {
    var numberField: some View{
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
            // evento de clique
        })
    }
}
extension SignInView {
    var registerLink: some View{
        VStack{
            Text("Ainda não possui login ativo?").foregroundColor(.gray).padding(.top,48)
            ZStack{
                NavigationLink(destination:Text("Tela de Cadastro"),
                               tag: 1,
                               selection: $action,
                               label: {EmptyView()})
                Button("Realize seu cadastro"){
                    self.action=1
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
