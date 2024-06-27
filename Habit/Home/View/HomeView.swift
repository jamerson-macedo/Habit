//
//  HomeView.swift
//  Habit
//
//  Created by Jamerson Macedo on 27/06/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel : HomeViewModel
    var body: some View {
        Text("Home Page")
    }
}

#Preview {
    
    HomeView(viewModel: HomeViewModel())
}
