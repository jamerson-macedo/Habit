//
//  ProfileView.swift
//  Habit
//
//  Created by Jamerson Macedo on 04/07/24.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel:ProfileViewModel
    
    @State var fullName = ""
    @State var email = "jamerson_macedp"
    @State var cpf = "10292921021"
    @State var phone = ""
    @State var birthday = ""
    @State var selectedGender:Gender? = .male
    var body: some View {
        NavigationView{
            
            VStack{
                Form{
                    Section(header :Text("Dados Cadastrais")){
                        HStack{
                            Text("Nome")
                            Spacer()
                            TextField("Digite o nome", text: $viewModel.fullNameValidation.value)
                                .keyboardType(.alphabet)
                                .multilineTextAlignment(.trailing)
                            
                                
                        }
                        if viewModel.fullNameValidation.failure{
                            Text("Nome deve ter mais de 3 caracteres").foregroundStyle(Color.red)
                        }
                        HStack{
                            Text("E-mail")
                            Spacer()
                            TextField("", text: $email)
                                .disabled(true)
                                .foregroundStyle(Color.gray)
                                .multilineTextAlignment(.trailing)
                            
                                
                        }
                        HStack{
                            Text("CPF")
                            Spacer()
                            TextField("", text: $cpf)
                                .disabled(true)
                                .foregroundStyle(Color.gray)
                                .multilineTextAlignment(.trailing)
                            
                                
                        }
                        HStack{
                            Text("Celular")
                            Spacer()
                            TextField("Digite o seu celular", text: $viewModel.phoneValidation.value)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                            
                        }
                        if viewModel.phoneValidation.failure{
                            Text("Entre com o DDD + 8 ou 9 digitos").foregroundStyle(Color.red)
                        }
                        HStack{
                            Text("Data de nascimento")
                            Spacer()
                            TextField("Digite a sua data de nascimento", text: $viewModel.birthdayValidation.value)
                                .multilineTextAlignment(.trailing)
                        }
                        if viewModel.birthdayValidation.failure{
                            Text("Data deve ser dd/MM/yyyy").foregroundStyle(Color.red)
                        }
                        NavigationLink(destination: GenderSelectorView(title: "Escolha um Gênero", genders: Gender.allCases, selectedgender: $selectedGender), label: {
                            Text("Gênero")
                            Spacer().frame(width: 160)
                            Text(selectedGender?.rawValue ?? "")
                            
                        })
                        
                    }
                }
                
            }
            .navigationBarTitle("Editar Perfil", displayMode: .automatic)
        }
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel())
}
