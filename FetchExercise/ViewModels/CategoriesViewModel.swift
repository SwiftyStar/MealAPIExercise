//
//  

import Foundation

final class CategoriesViewModel {
    private let networkManager: NetworkManager
    private var sortedCategories: [Category] = []
    
    private var categories: [Category] {
        didSet {
            let sortedCategories = self.categories.sorted { first, second in
                guard let firstName = first.name else { return true }
                guard let secondName = second.name else { return false }
                
                return firstName < secondName
            }
            
            self.sortedCategories = sortedCategories
        }
    }
    
    init(networkManager: NetworkManager = DefaultNetworkManager()) {
        self.networkManager = networkManager
        self.categories = []
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
            // Maybe instead of giving the error, give an enum for error state based on the error
            // Then the view can display content appropriately
        }
    }
    
    /// Gets the category for a given index
    /// - Parameter index: IndexPath
    /// - Returns: Category?
    func getCategory(for index: IndexPath) -> Category? {
        let row = index.row
        guard row < self.sortedCategories.count else { return nil }
        
        return self.sortedCategories[row]
    }
    
    /// Gets the number of rows the table view should display
    /// - Returns: Int
    func getNumberOfRows() -> Int {
        return self.sortedCategories.count
    }
}
