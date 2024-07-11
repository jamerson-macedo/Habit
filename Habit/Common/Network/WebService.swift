//
//  WebService.swift
//  Habit
//
//  Created by Jamerson Macedo on 29/06/24.
//

import Foundation
enum WebService {
    
    enum Endpoint: String {
        case base = "https://habitplus-api.tiagoaguiar.co"
        
        case postUser = "/users"
        case fetchUser = "/users/me"
        case login = "/auth/login"
        case refreshToken = "/auth/refresh-token"
        case habitts = "/users/me/habits"
        case habitValues = "/users/me/habits/%d/values"
        case updateUser = "/users/%d"
        
    }
    
    enum NetworkError {
        case badRequest
        case notFound
        case unauthorized
        case internalServerError
    }
    enum Method:String{
        case get
        case post
        case put
        case delete
        
    }
    
    
    enum Result {
        case success(Data)
        case failure(NetworkError, Data?)
    }
    
    enum ContentType: String {
        case json = "application/json"
        case formUrl = "application/x-www-form-urlencoded"
        case multipart = "multipart/form-data"
    }
    
    private static func completeUrl(path: String) -> URLRequest? {
        guard let url = URL(string: "\(Endpoint.base.rawValue)\(path)") else { return nil }
        
        return URLRequest(url: url)
    }
    
    public static func call(path: String,
                            method:Method,
                            contentType: ContentType,
                            data: Data?,
                            boundary:String = "",
                            completion: @escaping (Result) -> Void) {
        
        guard var urlRequest = completeUrl(path: path) else { return }
     _ = LocalDataSource.shared.getUserAuth().sink { userAuth in
            if let userAuth = userAuth{
                urlRequest.setValue("\(userAuth.tokenType) \(userAuth.idToken)", forHTTPHeaderField: "Authorization")
            }
         if  contentType == .multipart{
             urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

         }else {
             urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
         }
            urlRequest.httpMethod = method.rawValue
            urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
            urlRequest.httpBody = data
            
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                // roda em background (Non-MainThread)
                guard let data = data, error == nil else {
                    print(error)
                    completion(.failure(.internalServerError, nil))
                    return
                }
                
                if let r = response as? HTTPURLResponse {
                    switch r.statusCode {
                    case 400:
                        completion(.failure(.badRequest, data))
                        break
                    case 401:
                        completion(.failure(.unauthorized, data))
                        break
                    case 200:
                        completion(.success(data))
                        break
                    case 201:
                        completion(.success(data))
                        break
                    default:
                        break
                    }
                }
                
                print(String(data: data, encoding: .utf8))
                print("response\n")
                print(response)
                
            }
            
            task.resume()
        }
    }

        
    // chama a versao com JSON
    public static func call<T: Encodable>(path: Endpoint,
                                          method:Method = .get,
                                           body: T,
                                           completion: @escaping (Result) -> Void) {
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
        
        call(path: path.rawValue, method:method, contentType: .json, data: jsonData, completion: completion)
    }
    public static func call<T: Encodable>(path: String,
                                          method:Method = .get,
                                           body: T,
                                           completion: @escaping (Result) -> Void) {
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
        
        call(path: path, method:method, contentType: .json, data: jsonData, completion: completion)
    }
    public static func call(path: String, method:Method = .get, completion: @escaping (Result) -> Void) {
       
        
        call(path: path, method:method, contentType: .json, data: nil, completion: completion)
    }
    
    
    public static func call(path: Endpoint,
                                          method:Method = .get,
                                         
                                           completion: @escaping (Result) -> Void) {
       
        call(path: path.rawValue, method:method, contentType: .json, data: nil, completion: completion)
    }
    
    // chama a versão com UrlEncoded
   public static func call(path: Endpoint,
                           method:Method = .post,
                             params: [URLQueryItem],
                           data:Data?=nil,// valor da imagem
                             completion: @escaping (Result) -> Void) {
       guard let urlRequest = completeUrl(path: path.rawValue) else { return }
        
        guard let absoluteURL = urlRequest.url?.absoluteString else { return }
        var components = URLComponents(string: absoluteURL)
        components?.queryItems = params
        
       let boundary = "Boundary-\(NSUUID().uuidString)" // gera o numero aleatorio
       
       
       call(path: path.rawValue, method: method,
            contentType: data != nil ? .multipart : .formUrl,
            data: data != nil ? createBodyWithParameters(params:params,data:data!, boundary:boundary) : components?.query?.data(using: .utf8),
                boundary: boundary,
                completion: completion)
    }
    private static func createBodyWithParameters(params:[URLQueryItem],data:Data,boundary:String) ->Data{
        
        let body = NSMutableData()
        for param in params{
            body.appendString(string:"--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"\(param.name)\"\r\n\r\n")
            body.appendString(string: "\(param.value!)\r\n")
        }
        // mandando a foto
        let filename = "img.jpg"
        let mimetype = "iamge/jpeg"
        body.appendString(string:"--\(boundary)\r\n")
        body.appendString(string:"Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(data) // a foto em si
        body.appendString(string:"\r\n")
        body.appendString(string:"--\(boundary)--\r\n")
        return body as Data
        
    }
    
}
extension NSMutableData {
    func appendString(string:String){
        append(string.data(using: .utf8,allowLossyConversion: true)!)
    }
}
