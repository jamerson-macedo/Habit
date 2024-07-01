//
//  RemoteDataSource.swift
//  Habit
//
//  Created by Jamerson Macedo on 01/07/24.
//

import Foundation
import Combine
class SignInRemoteDataSource {
    // padrao singleton
    // ningume pode estanciar essa classe com o private
    static var shared : SignInRemoteDataSource = SignInRemoteDataSource()
    private init() {
        
    }
    // implementando o combine ele espera o a resposta e a falha
    func login(request :SignInRequest)->Future<SignInResponse,AppError>{
        
        return Future<SignInResponse,AppError>{ promisse in
            
            WebService.call(path: .login, params: [
                URLQueryItem(name: "username", value: request.email),
                URLQueryItem(name: "password", value: request.password)
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
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(SignInResponse.self, from: data)
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
