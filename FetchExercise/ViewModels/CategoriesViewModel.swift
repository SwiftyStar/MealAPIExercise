//
//  

import Foundation

final class CategoriesViewModel {
    private let networkManager: NetworkManager
    private var categories: [Category] = []
    
    init(networkManager: NetworkManager = DefaultNetworkManager()) {
        self.networkManager = networkManager
    }
    
    /// Retrieves the categories content from the API
    /// - Parameter completion: (Error?) -> Void callback for the API call. Returns an Error if there was a problem. Otherwise returns nil
    func getContent(completion: @escaping (Error?) -> Void) {
        self.networkManager.getData(from: MealAPI.categories) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let categories = try JSONDecoder().decode(Categories.self, from: data)
                    self?.categories = categories.categories
                    self?.handleSuccess(completion: completion)
                } catch {
                    self?.handleFailure(error: error, completion: completion)
                }
            case .failure(let error):
                self?.handleFailure(error: error, completion: completion)
            }
        }
    }
    
    private func handleSuccess(completion: @escaping (Error?) -> Void) {
        DispatchQueue.main.async {
            completion(nil)
        }
    }
    
    private func handleFailure(error: Error, completion: @escaping (Error?) -> Void) {
        DispatchQueue.main.async {
            completion(error)
        }
    }
    
    /// Gets the category for a given index
    /// - Parameter index: IndexPath
    /// - Returns: Category?
    func getCategory(for index: IndexPath) -> Category? {
        let row = index.row
        guard row < self.categories.count else { return nil }
        
        return self.categories[row]
    }
    
    /// Gets the number of rows the table view should display
    /// - Returns: Int
    func getNumberOfRows() -> Int {
        return self.categories.count
    }
}
