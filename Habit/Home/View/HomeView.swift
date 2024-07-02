//
//  HomeView.swift
//  Habit
//
//  Created by Jamerson Macedo on 27/06/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel : HomeViewModel
    @State var selection = 0
    // a tab clicada
    var body: some View {
        TabView(selection: $selection){
            Text("Conteudo de Habitos \(selection)")
                .tabItem {
                Image(systemName: "square.grid.2x2")
                    Text("Hábitos")
                }.tag(0)
            Text("Conteudo de graficos \(selection)")
                .tabItem {
                Image(systemName: "chart.bar")
                    Text("Gráficos")
                }.tag(1)
            Text("Conteudo de perfil \(selection)")
                .tabItem {
                Image(systemName: "person.crop.circle")
                    Text("Perfil")
                }.tag(2)
        }
        .background(Color.white)
        .accentColor(Color.orange)
    }
}

#Preview {
    
    HomeView(viewModel: HomeViewModel())
}
