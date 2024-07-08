//
//  HabitView.swift
//  Habit
//
//  Created by Jamerson Macedo on 02/07/24.
//

import SwiftUI

struct HabitView: View {
    @ObservedObject var viewModel: HabitViewModel
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        Group{
            ZStack {
                if case HabitUIState.loading = viewModel.uiState {
                    progress
                } else {
                    
                    NavigationView {
                        
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 12) {
                                if !viewModel.isChart{
                                    topContainer
                                    
                                    addButton
                                }
                                if case HabitUIState.emptyList = viewModel.uiState {
                                    
                                    Spacer(minLength: 60)
                                    
                                    VStack {
                                        Image(systemName: "exclamationmark.octagon.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 24, height: 24, alignment: .center)
                                        
                                        Text("Nenhum hábito encontrado :(")
                                    }
                                    
                                } else if case HabitUIState.fullList(let rows) = viewModel.uiState {
                                    
                                    LazyVStack {
                                        
                                        ForEach(rows){ row in
                                            HabitCardView(isChart: viewModel.isChart, viewModel: row)
                                            
                                        }
                                        
                                    }.padding(.horizontal, 14)
                                    
                                } else if case HabitUIState.error(let msg) = viewModel.uiState {
                                    
                                    Text("").onAppear{
                                        showAlert=true
                                        alertMessage = msg
                                    }
                                        
                                    
                                }
                                
                            }
                        }.navigationTitle("Meus Hábitos")
                        
                    }
                }
                
            }.onAppear {
                if(!viewModel.opened){
                    viewModel.onAppear()
                }
            }
           
          
        }.alert(isPresented: $showAlert) {
            Alert(
                title: Text("Ops! \(alertMessage)"),
                message: Text("Tentar novamente?"),
                primaryButton: .default(Text("Sim")) {
                    // aqui executa a retentativa
                    viewModel.onAppear()
                },
                secondaryButton: .cancel()
            )
        }
    }
}

extension HabitView {
    var progress: some View {
        ProgressView()
    }
}

extension HabitView {
    var topContainer: some View {
        VStack(alignment: .center, spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50, alignment: .center)
            
            Text(viewModel.title)
                .font(Font.system(.title).bold())
                .foregroundColor(Color.orange)
            
            Text(viewModel.headline)
                .font(Font.system(.title3).bold())
                .foregroundColor(Color("textColor"))
            
            Text(viewModel.desc)
                .font(Font.system(.subheadline))
                .foregroundColor(Color("textColor"))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.gray, lineWidth: 1)
        )
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
}

extension HabitView {
    var addButton: some View {
        NavigationLink(destination: Text("Tela de adicionar")
            .frame(maxWidth: .infinity, maxHeight: .infinity)) {
                Label("Criar Hábito", systemImage: "plus.app")
                    .modifier(ButtonStyle())
            }
            .padding(.horizontal, 16)
    }
}


#Preview("Light") {
    HabitView(viewModel: HabitViewModel(isCharts: false, interactor: HabitInteractor()))
}
#Preview("Dark"){
    HabitView(viewModel: HabitViewModel(isCharts: false, interactor: HabitInteractor())).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
