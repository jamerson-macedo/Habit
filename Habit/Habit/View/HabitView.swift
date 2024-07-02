//
//  HabitView.swift
//  Habit
//
//  Created by Jamerson Macedo on 02/07/24.
//

import SwiftUI

struct HabitView: View {
    @ObservedObject var viewModel :HabitViewModel
    
    var body: some View {
        ZStack{
            if case HabitUIState.loading = viewModel.uiState{
                progress
                
            } else {
                NavigationView{
                    ScrollView(showsIndicators: false){
                        VStack(spacing:12){
                            topContainer
                            addButton
                            
                            if case HabitUIState.emptyList = viewModel.uiState{
                                Spacer(minLength: 60)
                                VStack{
                                    Image(systemName: "exclamationmark.octagon.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24,height: 24,alignment: .center)
                                    Text("Nenhum Hábito encontrado :(")
                                }
                            }
                            else if case HabitUIState.fullList = viewModel.uiState{
                                // lista cheia
                            }
                            else if case HabitUIState.error = viewModel.uiState{
                                // error
                            }
                        }
                    }
                }
            }
        }
    }
}

extension HabitView {
    var progress:some View{
        ProgressView()
    }
}
extension HabitView {
    var addButton:some View{
        NavigationLink(destination:Text("destino").frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)){
            Label("Criar Habito", systemImage: "plus.app")
                .modifier(ButtonStyle())
        }.navigationTitle("Meus Hábitos").padding(.horizontal,16)
    }
}

extension HabitView{
    var topContainer:some View{
        VStack(alignment:.center,spacing: 12){
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .frame(width: 50,height: 50,alignment: .center)
            Text(viewModel.title).font(Font.system(.title).bold())
                .foregroundStyle(Color.orange)
            Text(viewModel.headline).font(Font.system(.title3).bold())
                .foregroundStyle(Color("textColor"))
            Text(viewModel.desc).font(Font.system(.subheadline))
                .foregroundStyle(Color("textColor"))
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .padding(.vertical,32)
            .overlay{
                // coloca um objeto dentro da view
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.gray, lineWidth: 1)
            }
            .padding(.horizontal,16)
            .padding(.top,16)
    }
}

#Preview("Light") {
    HabitView(viewModel: HabitViewModel())
}
#Preview("Dark"){
    HabitView(viewModel: HabitViewModel()).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
