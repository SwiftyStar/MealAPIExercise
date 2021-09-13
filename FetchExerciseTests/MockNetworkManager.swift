//
//  

import Foundation
import FetchExercise

struct MockNetworkManager: FetchExercise.NetworkManager {
    let data: Data?
    let error: Error?
    
    @discardableResult
    func getData(from apiRequest: APIRequest, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask? {
        guard let data = self.data else {
            let errorToReturn = self.error ?? URLError(.badServerResponse)
            completion(.failure(errorToReturn))
            return URLSession(configuration: .default).dataTask(with: URL(string: "https://www.google.com")!)
        }
        
        completion(.success(data))
        return URLSession(configuration: .default).dataTask(with: URL(string: "https://www.google.com")!)
    }
    
    @discardableResult
    func getData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask {
        guard let data = self.data else {
            let errorToReturn = self.error ?? URLError(.badServerResponse)
            completion(.failure(errorToReturn))
            return URLSession(configuration: .default).dataTask(with: URL(string: "https://www.google.com")!)
        }
        
        completion(.success(data))
        return URLSession(configuration: .default).dataTask(with: URL(string: "https://www.google.com")!)
    }
    
    
}
