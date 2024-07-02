//
//  SplashRemoteDataSource.swift
//  Habit
//
//  Created by Jamerson Macedo on 01/07/24.
//

import Foundation
import Combine
class SplashRemoteDataSource{
    // padrao singleton
    // ningume pode estanciar essa classe com o private
    static var shared : SplashRemoteDataSource = SplashRemoteDataSource()
    private init() {
        
    }
    // implementando o combine ele espera o a resposta e a falha
    func refreshToken(request :RefreshRequest)->Future<SignInResponse,AppError>{
        
        return Future<SignInResponse,AppError>{ promisse in
            
            WebService.call(path:.refreshToken, method : .put,body: request) { result in
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
