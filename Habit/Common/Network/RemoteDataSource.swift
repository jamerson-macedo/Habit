//
//  RemoteDataSource.swift
//  Habit
//
//  Created by Jamerson Macedo on 01/07/24.
//

import Foundation
class RemoteDataSource {
    // padrao singleton
    // ningume pode estanciar essa classe com o private
    static var shared : RemoteDataSource = RemoteDataSource()
    private init() {
        
    }
    func login(request :SignInRequest, completion : @escaping (SignInResponse?,SignInError?)->Void){
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
                        completion(nil, response)
                    }
                }
                break
            case .success(let data):
                let decoder = JSONDecoder()
                let response = try? decoder.decode(SignInResponse.self, from: data)
                completion(response, nil)
                break
            }
        }
        
    }
}
