//
//  HabitCreateDataSource.swift
//  Habit
//
//  Created by Jamerson Macedo on 10/07/24.
//

import Foundation
import Combine
class HabitCreateDataSource {
    static var shared: HabitCreateDataSource = HabitCreateDataSource()
      
      private init() {
      }
      
      func save(request: HabitCreateRequest) -> Future<Void, AppError> {
        return Future<Void,AppError> { promise in
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
                    
                    promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido no servidor")))
                  }
                }
                break
              case .success(_):
                promise(.success( () ))
                
                break
            }
          }
        }
        
      }
      
    }
