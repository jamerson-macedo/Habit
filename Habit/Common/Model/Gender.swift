//
//  Gender.swift
//  Habit
//
//  Created by Jamerson Macedo on 28/06/24.
//

import Foundation
enum Gender : String, CaseIterable, Identifiable{
    case male = "Masculino"
    case female = "Feminino"
    
    var id : String{
        self.rawValue
    }
    
}
// caseiTERABLE : É para poder fazer foreach
// iDENTIGIABLE : é para ser unico
