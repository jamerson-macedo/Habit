//
//  ProfileRemoteDataSource.swift
//  Habit
//
//  Created by Jamerson Macedo on 04/07/24.
//

import Foundation
import Combine
class ProfileRemoteDataSource {
    // padrao singleton
    // ningume pode estanciar essa classe com o private
    static var shared : ProfileRemoteDataSource = ProfileRemoteDataSource()
    private init() {
        
    }
    // implementando o combine ele espera o a resposta e a falha
   
   func fetchUser() -> Future<ProfileResponse,AppError>{
       return Future { promisse in
           WebService.call(path: .fetchUser,method: .get) { result in
               switch result {
               case .failure(_, let data):
                   if let data = data {
                       
                       let decoder = JSONDecoder()
                       let response = try? decoder.decode(ErrorResponse.self, from: data)
                       // completion(nil, response)
                       promisse(.failure(AppError.response(message: response?.detail ?? "Erro desconhecido")))
                       
                   }
                   break
               case .success(let data):
                   //completion(true, nil)
                   let decoder = JSONDecoder()
                   let response = try? decoder.decode(ProfileResponse.self, from: data)
                   guard let res = response else {
                       print("LOG: ERROR PARSER \(String(data: data, encoding: .utf8)!)")
                       return}
                   
                   promisse(.success(res))
                   break
               }
           }
           
       }
   
    }
    
}
    
