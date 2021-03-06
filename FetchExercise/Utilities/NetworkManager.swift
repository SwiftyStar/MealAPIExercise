//
//  

import Foundation

public protocol NetworkManager {
    @discardableResult
    func getData(from apiRequest: APIRequest, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask?
    
    @discardableResult
    func getData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask
}

struct DefaultNetworkManager: NetworkManager {
    
    @discardableResult
    func getData(from apiRequest: APIRequest, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask? {
        var components = URLComponents()
        components.scheme = apiRequest.scheme
        components.host = apiRequest.host
        components.path = apiRequest.path
        components.queryItems = apiRequest.queries?.map({ key, value in
            URLQueryItem(name: key, value: value)
        })
        
        guard let url = components.url else {
            completion(.failure(URLError(.badURL)))
            return nil
        }
        
        let request = URLRequest(url: url,
                                 cachePolicy: .returnCacheDataElseLoad,
                                 timeoutInterval: 30)
        
        let dataTask = URLSession(configuration: .default).dataTask(with: request) { data, _, error in
            guard let receivedData = data else {
                let receivedError = error ?? URLError(.badServerResponse)
                completion(.failure(receivedError))
                return
            }
            
            completion(.success(receivedData))
        }
        
        dataTask.resume()
        return dataTask
    }
    
    @discardableResult
    func getData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask {
        let request = URLRequest(url: url,
                                 cachePolicy: .returnCacheDataElseLoad,
                                 timeoutInterval: 30)
        
        let dataTask = URLSession(configuration: .default).dataTask(with: request) { data, _, error in
            guard let receivedData = data else {
                let receivedError = error ?? URLError(.badServerResponse)
                completion(.failure(receivedError))
                return
            }
            
            completion(.success(receivedData))
        }
        
        dataTask.resume()
        return dataTask
    }
}
