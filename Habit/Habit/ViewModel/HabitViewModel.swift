//
//  HabitViewModel.swift
//  Habit
//
//  Created by Jamerson Macedo on 02/07/24.
//

import Foundation
class HabitViewModel :ObservableObject{
    @Published var uiState : HabitUIState = .loading
    @Published var title = "Atenção"
    @Published var headline = "Fique ligado!"
    @Published var desc = "Voce esta atrasado nos hábitos"
    
    func onAppear(){
        self.uiState = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            var rows : [HabitCardViewModel] = []
            rows.append(HabitCardViewModel(id: 1,
                                           icon: "https://via.placeholder.com/150",
                                           date: "01/01/2021 00",
                                           name: "Tocar guitarra",
                                           label: "horas",
                                           value: "2",
                                           state: .green))
            rows.append(HabitCardViewModel(id: 2,
                                           icon: "https://via.placeholder.com/150",
                                           date: "01/01/2023 12:00:00",
                                           name: "Fazer caminhada",
                                           label: "km",
                                           value: "5",
                                           state: .green))
            rows.append(HabitCardViewModel(id: 3,
                                           icon: "https://via.placeholder.com/150",
                                           date: "01/01/2021 00:00:00",
                                           name: "Tocar guitarra",
                                           label: "horas",
                                           value: "2",
                                           state: .red))
            rows.append(HabitCardViewModel(id: 4,
                                           icon: "https://via.placeholder.com/150",
                                           date: "01/01/2023 12:00:00",
                                           name: "Fazer caminhada",
                                           label: "km",
                                           value: "5",
                                           state: .green))
            self.uiState = .fullList(rows)        }
    }
}
