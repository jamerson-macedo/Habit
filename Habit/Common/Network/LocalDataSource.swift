//
//  LocalDataSource.swift
//  Habit
//
//  Created by Jamerson Macedo on 01/07/24.
//

import Foundation
import Combine
class LocalDataSource {
    
    // fazendo o singleton
    static var shared :LocalDataSource = LocalDataSource()
    
    private func saveValue(value : UserAuth){
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: "user_key")
    }
    
    private func readValue(key:String)->UserAuth?{
        var userAuth : UserAuth?
        // se conseguir recuperar
        if let data = UserDefaults.standard.value(forKey: key) as? Data{
            userAuth = try? PropertyListDecoder().decode(UserAuth.self, from:data)
        }
        return userAuth
        
    }
}

extension LocalDataSource{
    func insertUserAuth(userAuth:UserAuth){
        saveValue(value: userAuth)
    }
    func getUserAuth()->Future<UserAuth?,Never>{
        let userAuth = readValue(key: "user_key")
        return Future { promisse in
            promisse(.success(userAuth))
            
        }
    }
}
