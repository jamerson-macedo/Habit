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
    var index :Self.AllCases.Index{
        return Self.allCases.firstIndex{ self == $0 } ?? 0
    }
    
}
// caseiTERABLE : É para poder fazer foreach
// iDENTIGIABLE : é para ser unico
