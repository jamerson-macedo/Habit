//
//  ChartUiState.swift
//  Habit
//
//  Created by Jamerson Macedo on 09/07/24.
//

import Foundation
enum ChartUiState:Equatable{
    case loading
    case emptyChart
    case fullChart
    case error(String)
}
