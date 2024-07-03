//
//  HabitRemoteDataSource.swift
//  Habit
//
//  Created by Jamerson Macedo on 03/07/24.
//

import Foundation
import Combine
// padrao singleton
// ningume pode estanciar essa classe com o private
class HabitRemoteDataSource{
static var shared : HabitRemoteDataSource = HabitRemoteDataSource()
private init() {
    
}
// implementando o combine ele espera o a resposta e a falha
func fetchHabits()->Future<[HabitResponse],AppError>{
    
    return Future<[HabitResponse],AppError>{ promisse in
        
        WebService.call(path:.habitts,method: .get){ result in
            switch result {
            case .failure(_, let data):
                if let data = data {
                   
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(SignInError.self, from: data)
                       // completion(nil, response)
                        promisse(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido")))
                    
                }
                break
            case .success(let data):
                let decoder = JSONDecoder()
                let response = try? decoder.decode([HabitResponse].self, from: data)
               // completion(response, nil)
                
                guard let response = response else { print("Log : Error parser\(String(describing: String(data: data, encoding: .utf8)))")
                    return
                }
                promisse(.success(response))
                break
            }
        }
        
    }
    
    
}
}
