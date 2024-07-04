//
//  ProfileView.swift
//  Habit
//
//  Created by Jamerson Macedo on 04/07/24.
//

import SwiftUI

struct ProfileView: View {
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
                            TextField("Digite o nome", text: $fullName)
                                .keyboardType(.alphabet)
                                .multilineTextAlignment(.trailing)
                            
                                
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
                            TextField("Digite o seu celular", text: $phone)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                            
                        }
                        HStack{
                            Text("Data de nascimento")
                            Spacer()
                            TextField("Digite a sua data de nascimento", text: $birthday)
                                .multilineTextAlignment(.trailing)
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
    ProfileView()
}
