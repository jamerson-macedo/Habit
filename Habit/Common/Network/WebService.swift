//
//  WebService.swift
//  Habit
//
//  Created by Jamerson Macedo on 29/06/24.
//

import Foundation
enum WebService {
    enum Endpoint:String{
        case base = "https://habitplus-api.tiagoaguiar.co"
        case postUser = "/users"
    }
    // juntando os endponts
    private static func completeUrl(patch:Endpoint)->URLRequest?{
        guard let url = URL(string: "\(Endpoint.base.rawValue)\(patch.rawValue)") else {return nil}
        return URLRequest(url: url)
        
    }
    
    static func postUser(request : SignUpRequest){
     
        guard let jsonData = try? JSONEncoder().encode(request) else {return}
        
        
        guard var urlRequest = completeUrl(patch: .postUser) else {return}
// É PRECISO CRIAR A REQUISIÇÃO
//        curl -X 'POST' \
//          'https://habitplus-api.tiagoaguiar.co/users' \
//          -H 'accept: application/json' \
//          -H 'Content-Type: application/json' \
//          -d '{
//          "name": "string",
//          "email": "string",
//          "document": "string",
//          "phone": "string",
//          "gender": 0,
//          "birthday": "2024-06-29",
//          "password": "string"
//        }'
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: urlRequest){ data ,response, error in
            guard let data = data, error == nil else {
                print(error)
                return
            }
            print(String(data: data, encoding: .utf8))
            print(response)
            if let r = response as? HTTPURLResponse{
                print(r.statusCode)
            }
        }
        task.resume()
    }
}
