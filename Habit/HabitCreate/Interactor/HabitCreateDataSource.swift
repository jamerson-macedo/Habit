//
//  HabitCreateDataSource.swift
//  Habit
//
//  Created by Jamerson Macedo on 10/07/24.
//

import Foundation
import Combine
class HabitCreateDataSource {
    // padrao singleton
    // ningume pode estanciar essa classe com o private
    static var shared : HabitCreateDataSource = HabitCreateDataSource()
    private init() {
        
    }
    // implementando o combine ele espera o a resposta e a falha
    func save(request :HabitCreateRequest)->Future<Void,AppError>{
        
        return Future<Void,AppError>{ promisse in
            
            WebService.call(path: .habitts, params: [
                URLQueryItem(name: "name", value: request.name),
                URLQueryItem(name: "label", value: request.label)
            ]) { result in
                switch result {
                case .failure(let error, let data):
                    if let data = data {
                        if error == .unauthorized {
                            let decoder = JSONDecoder()
                            let response = try? decoder.decode(SignInError.self, from: data)
                           // completion(nil, response)
                            promisse(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido")))
                        }
                    }
                    break
                case .success(_):
                  
                    
                    promisse(.success( () )) // void
                    break
                }
            }
            
        }
        
        
    }
}
