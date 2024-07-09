//
//  ChartView.swift
//  Habit
//
//  Created by Jamerson Macedo on 08/07/24.
//

import SwiftUI
import Charts
struct ChartView: View {
    @ObservedObject var viewModel:ChartViewModel
    var body: some View {
        ZStack{
            if case ChartUiState.loading = viewModel.uiState{
                ProgressView()
            }else {
                VStack {
                    if case ChartUiState.emptyChart = viewModel.uiState{
                        
                        Image(systemName: "exclamationmark.octagon.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24, alignment: .center)
                        
                        Text("Nenhum hábito encontrado :(")
                    }else if case ChartUiState.error(let msg) = viewModel.uiState {
                        
                        Text("").alert(isPresented:.constant(true)){
                            Alert(title: Text("Habit"),
                                  message: Text(msg),
                                  dismissButton: .default(Text("Ok")){
                                
                            })
                            
                        }
                    }else {
                        BoxChartView(entries: $viewModel.entries, dates: $viewModel.dates).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: 350)
                    }
                    
                }
                
            }
        }.onAppear(perform: viewModel.onAppear)
    }
}

#Preview {
    HabitCardViewRouter.makeChartView(id: 1)
}
