//
//  HabitDetailView.swift
//  Habit
//
//  Created by Jamerson Macedo on 03/07/24.
//

import SwiftUI

struct HabitDetailView: View {
    @ObservedObject var viewModel :HabitDetailViewModel
    // referencia da viewcorrente
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    
    init(viewModel: HabitDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(alignment :.center,spacing: 12){
                Text(viewModel.name)
                    .foregroundStyle(Color.orange)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                
                Text("Unidade: \(viewModel.label)")
            }
            VStack{
                TextField("Ëscreva aqui o valor conquistado",text: $viewModel.value)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.plain)
                    .keyboardType(.numberPad)
                Divider().frame(height: 1).background(Color.gray)
            }.padding(.horizontal,32)
            
            Text("Os registros devem ser feitos em ate 24h.\nHábitos se constroem todos os dias :)")
            LoadingButtonView(action: {
                viewModel.save()
            },
                              disabled: self.viewModel.value.isEmpty, showProgress: self.viewModel.uiState == .loading, text: "Salvar")
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
    HabitDetailView(viewModel: HabitDetailViewModel(id: 1, name: "tocar guitarra", label: "horas", interactor: HabitDetailInteractor()))
}
#Preview {
    HabitDetailView(viewModel: HabitDetailViewModel(id: 1, name: "tocar guitarra", label: "horas", interactor: HabitDetailInteractor())).preferredColorScheme(.dark)
    
}
    
