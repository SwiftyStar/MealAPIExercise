//
//  

import Foundation

protocol NetworkManager {
    func getData(from apiRequest: APIRequest, completion: @escaping (Result<Data, Error>) -> Void)
}

final class DefaultNetworkManager: NetworkManager {
    
    func getData(from apiRequest: APIRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = apiRequest.baseURL.appendingPathComponent(apiRequest.path)
        let request = URLRequest(url: url,
                                 cachePolicy: .returnCacheDataElseLoad,
                                 timeoutInterval: 30)
        
        URLSession(configuration: .default).dataTask(with: request) { data, _, error in
            guard let receivedData = data else {
                let receivedError = error ?? NSError()
                completion(.failure(receivedError))
                return
            }
            
            completion(.success(receivedData))
        }.resume()
    }
}
