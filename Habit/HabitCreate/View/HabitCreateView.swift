//
//  HabitCreateView.swift
//  Habit
//
//  Created by Jamerson Macedo on 09/07/24.
//

import SwiftUI

struct HabitCreateView: View {
    @ObservedObject var viewModel :HabitCreateViewModel
    // referencia da viewcorrente
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    
    @State private var shoudPresentCamera = false
    
    init(viewModel: HabitCreateViewModel) {
        self.viewModel = viewModel
        
    }
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(alignment :.center,spacing: 12){
                Button(action: {
                    self.shoudPresentCamera = true
                }, label: {
                    VStack{
                        Image(systemName: "camera.fill").resizable().scaledToFit().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100).foregroundColor(Color.orange)
                        Text("Clique aqui para enviar").foregroundStyle(Color.orange)
                    }
                }).padding(.bottom,12)
            }
            VStack{
                TextField("Ëscreva aqui o nome do Hábito",text: $viewModel.name)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.plain)
                   
                Divider().frame(height: 1).background(Color.gray)
            }.padding(.horizontal,32)
            VStack{
                TextField("Ëscreva aqui a unidade de medida",text: $viewModel.label)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.plain)
        
                Divider().frame(height: 1).background(Color.gray)
            }.padding(.horizontal,32)
            
            LoadingButtonView(action: {
                viewModel.save()
            },
                              disabled: self.viewModel.name.isEmpty || self.viewModel.label.isEmpty, showProgress: self.viewModel.uiState == .loading, text: "Salvar")
            .padding(.horizontal,16)
            .padding(.vertical,8)
            
            Button("Cancelar"){
                // tirar da tela
                self.presentationMode.wrappedValue.dismiss()
            }
          
            .modifier(ButtonStyle())
            .padding(.horizontal,16)
            
            Spacer()
        }
        .padding(.horizontal,8)
        .padding(.top,32)
        .onAppear{
            viewModel.$uiState.sink { uiState in
                if uiState == .success{
                    // se veio sucesso ai ele tira da principal
                    self.presentationMode.wrappedValue.dismiss()
                }
            }.store(in: &viewModel.cancellables)
        }
    }
}


#Preview {
    HabitCreateView(viewModel: HabitCreateViewModel(interactor: HabitDetailInteractor()))
}
