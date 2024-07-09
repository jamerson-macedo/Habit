//
//  ChartViewModel.swift
//  Habit
//
//  Created by Jamerson Macedo on 09/07/24.
//

import Foundation
import SwiftUI
import Charts
class ChartViewModel : ObservableObject{
    @Published var entries: [ChartDataEntry] = [ChartDataEntry(x: 1.0, y: 2.0),
                                                ChartDataEntry(x: 2.0, y: 6.0),
                                                ChartDataEntry(x: 3.0, y: 7.0),
                                                ChartDataEntry(x: 4.0, y: 8.0),
                                                ChartDataEntry(x: 5.0, y: 3.0),
                                                ChartDataEntry(x: 6.0, y: 2.0),
                                                ChartDataEntry(x: 7.0, y: 33.0),
                                                ChartDataEntry(x: 8.0, y: 4.0)]
    @Published var dates = ["09/09/2000","02/09/2000","01/09/2000","06/09/2000","08/09/2000","09/09/2000","01/09/2000","09/010/2000",]
}
