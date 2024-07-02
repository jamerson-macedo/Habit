//
//  SignUpRemoteDataSource.swift
//  Habit
//
//  Created by Jamerson Macedo on 01/07/24.
//

import Foundation
import Combine
class SignUpRemoteDataSource {
    // padrao singleton
    // ningume pode estanciar essa classe com o private
    static var shared : SignUpRemoteDataSource = SignUpRemoteDataSource()
    private init() {
        
    }
    // implementando o combine ele espera o a resposta e a falha
   
            
        
   func postUser(request: SignUpRequest) -> Future<Bool,AppError>{
       return Future { promisse in
           WebService.call(path: .postUser,method: .post, body: request) { result in
               switch result {
               case .failure(let error, let data):
                   if let data = data {
                       if error == .badRequest {
                           let decoder = JSONDecoder()
                           let response = try? decoder.decode(ErrorResponse.self, from: data)
                          // completion(nil, response)
                           promisse(.failure(AppError.response(message: response?.detail ?? "Erro desconhecido")))
                       }
                   }
                   break
               case .success(_):
                   //completion(true, nil)
                   promisse(.success(true))
                   break
               }
           }
           
       }
   
    }
    
}
    
