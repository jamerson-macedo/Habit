//
//  HabitDetailRemoteDataSource.swift
//  Habit
//
//  Created by Jamerson Macedo on 03/07/24.
//

import Foundation
import Combine
class HabitDetailRemoteDataSource{
    // padrao singleton
    // ningume pode estanciar essa classe com o private
    static var shared : HabitDetailRemoteDataSource = HabitDetailRemoteDataSource()
    private init() {
        
    }
    // implementando o combine ele espera o a resposta e a falha
    func save(habitId:Int,request :HabitValueRequest)->Future<Bool,AppError>{
        
        return Future<Bool,AppError>{ promisse in
            let patch = String(format: WebService.Endpoint.habitValues.rawValue, habitId)
            WebService.call(path: patch,method: .post,body: request) { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(SignInError.self, from: data)
                        // completion(nil, response)
                        promisse(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido")))
                        
                    }
                    break
                case .success(_):
                
                    promisse(.success(true))
                    break
                }
            }
            
        }
        
        
    }


}
