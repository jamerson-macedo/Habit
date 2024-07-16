//
//  ProfileView.swift
//  Habit
//
//  Created by Jamerson Macedo on 04/07/24.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel:ProfileViewModel
    var disableDone :Bool{
        viewModel.fullNameValidation.failure || viewModel.phoneValidation.failure ||
        viewModel.birthdayValidation.failure
    }
    
    var body: some View {
        ZStack{
            if case ProfileUiState.loading = viewModel.uiState{
                ProgressView()
            }else {
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
                                    TextField("", text:$viewModel.email)
                                        .disabled(true)
                                        .foregroundStyle(Color.gray)
                                        .multilineTextAlignment(.trailing)
                                    
                                    
                                }
                                HStack{
                                    Text("CPF")
                                    Spacer()
                                    TextField("", text: $viewModel.document)
                                        .disabled(true)
                                        .foregroundStyle(Color.gray)
                                        .multilineTextAlignment(.trailing)
                                    
                                    
                                }
                                HStack{
                                    Text("Celular")
                                    Spacer()
                                    ProfileEditText(placeholder: "Digite seu telefone", mask: "(##) ####-####", keyboard: .numberPad, text: $viewModel.phoneValidation.value)
                                   
                                    
                                }
                                if viewModel.phoneValidation.failure{
                                    Text("Entre com o DDD + 8 ou 9 digitos").foregroundStyle(Color.red)
                                }
                                HStack{
                                    Text("Data de nascimento")
                                    Spacer()
                                    ProfileEditText(placeholder: "Digite a sua data de nascimento", mask: "##/##/####", keyboard: .numberPad, text: $viewModel.birthdayValidation.value)
                                   
                                    
                                }
                                if viewModel.birthdayValidation.failure{
                                    Text("Data deve ser dd/MM/yyyy").foregroundStyle(Color.red)
                                }
                                NavigationLink(destination: GenderSelectorView(title: "Escolha um Gênero", genders: Gender.allCases, selectedgender: $viewModel.gender), label: {
                                    Text("Gênero")
                                    Spacer().frame(width: 160)
                                    Text(viewModel.gender?.rawValue ?? "")
                                    
                                })
                                
                            }
                        }
                        
                    }
                    .navigationBarTitle("Editar Perfil", displayMode: .automatic)
                    .navigationBarItems(trailing: Button(action: {
                        viewModel.updateUser()
                    }, label: {
                        if case ProfileUiState.updateLoading = viewModel.uiState{
                            ProgressView()
                        }else {
                            Image(systemName: "checkmark").foregroundStyle(Color.orange)
                        }
                    }).alert(isPresented: .constant(viewModel.uiState == .updateSuccess )) {
                        Alert(title: Text("Habit"),message: Text("Dados atualizados com sucesso!"),dismissButton: .default(Text("OK")){
                            viewModel.uiState = .none
                        })
                    }
                        .opacity(disableDone ? 0 : 1) // opacidade do botao
                    )
                    
                }
            }
            if case ProfileUiState.updateError(let error) = viewModel.uiState{
                Text("").alert(isPresented:.constant(true)){
                    Alert(title: Text("Habit"),
                          message: Text(error),
                          dismissButton: .default(Text("Ok")){
                        viewModel.uiState = .none
                        
                        
                    })
                    
                }
            }
            
            if case ProfileUiState.fetchError(let error) = viewModel.uiState{
                Text("").alert(isPresented:.constant(true), content: {
                    Alert(title: Text("Habit"),message: Text(error), dismissButton: .default(Text("Ok")))
                })
                
            }
        }.onAppear(perform: {viewModel.fetchUser()})
        
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel(interactor: ProfileInteractor()))
}
