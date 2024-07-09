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
        BoxChartView(entries: $viewModel.entries, dates: $viewModel.dates).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: 350)
    }
}

#Preview {
    ChartView(viewModel: ChartViewModel())
}
