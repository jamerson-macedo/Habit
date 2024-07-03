//
//  HabitViewModel.swift
//  Habit
//
//  Created by Jamerson Macedo on 02/07/24.
//

import Foundation
import SwiftUI
import Combine
class HabitViewModel :ObservableObject{
    @Published var uiState : HabitUIState = .loading
    @Published var title = ""
    @Published var headline = ""
    @Published var desc = ""
    
    private var cancellableRequest : AnyCancellable?
    private let interactor : HabitInteractor
    
    init(interactor:HabitInteractor){
        self.interactor=interactor
    }
    deinit{
        cancellableRequest?.cancel()
    }
    
    func onAppear(){
        self.uiState = .loading
        
        
        cancellableRequest = interactor.fetchHabits()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion){
                case.failure(let appError):
                    self.uiState = .error(appError.message ?? "Error desconhecido")
                    break
                case .finished:
                    break
                }
            }, receiveValue: { response in
                if response.isEmpty{
                    self.uiState = .emptyList
                    self.title = ""
                    self.headline="Fique ligado"
                    self.desc = "voce ainda não possui habitos"
                    
                }else {
                    self.uiState = .fullList(
                        response.map{
                            
                            let lastDate = $0.lastDate?.toDate(source: "yyyy-MM-dd'T'HH:mm:ss", dest: "dd/MM/yyyy HH:mm") ?? ""
                            
                            var state = Color.green
                            self.title = "Muito bom!"
                            self.headline = "Seus Hábitos estão em dia"
                            self.desc = ""
                            if lastDate<Date().toString(dest: "dd/MM/yyyy"){
                                state = .red
                                self.title = "Atenção"
                                self.headline = "Fique ligado"
                                self.desc = "Voce esta atrasado nos Habitos"
                            }
                            
                            return HabitCardViewModel(id:$0.id, icon: $0.iconUrl ?? "", date: lastDate,name: $0.name,label: $0.label,value: "\($0.value ?? 0)")
                                        
                            
                        
                        }
                    )
                }
                
            })
        
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
//            var rows : [HabitCardViewModel] = []
//            rows.append(HabitCardViewModel(id: 1,
//                                           icon: "https://via.placeholder.com/150",
//                                           date: "01/01/2021 00",
//                                           name: "Tocar guitarra",
//                                           label: "horas",
//                                           value: "2",
//                                           state: .green))
//            rows.append(HabitCardViewModel(id: 2,
//                                           icon: "https://via.placeholder.com/150",
//                                           date: "01/01/2023 12:00:00",
//                                           name: "Fazer caminhada",
//                                           label: "km",
//                                           value: "5",
//                                           state: .green))
//            rows.append(HabitCardViewModel(id: 3,
//                                           icon: "https://via.placeholder.com/150",
//                                           date: "01/01/2021 00:00:00",
//                                           name: "Tocar guitarra",
//                                           label: "horas",
//                                           value: "2",
//                                           state: .red))
//            rows.append(HabitCardViewModel(id: 4,
//                                           icon: "https://via.placeholder.com/150",
//                                           date: "01/01/2023 12:00:00",
//                                           name: "Fazer caminhada",
//                                           label: "km",
//                                           value: "5",
//                                           state: .green))
//            self.uiState = .fullList(rows)        }
    }
}
