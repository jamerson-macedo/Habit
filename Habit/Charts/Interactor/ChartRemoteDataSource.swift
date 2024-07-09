//
//  ChartRemoteDataSource.swift
//  Habit
//
//  Created by Jamerson Macedo on 09/07/24.
//

import Foundation
import Combine

class ChartRemoteDataSource {
    // ningume pode estanciar essa classe com o private
    static var shared : ChartRemoteDataSource = ChartRemoteDataSource()
    private init() {
        
    }
    // implementando o combine ele espera o a resposta e a falha
    
    func fetchHabiValues(habitId:Int) -> Future<[HabitValueReponse],AppError>{
        return Future { promisse in
            
            let path = String(format: WebService.Endpoint.habitValues.rawValue, habitId)
            
            WebService.call(path: path, method: .get) { result in
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
                    let response = try? decoder.decode([HabitValueReponse].self, from: data)
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
