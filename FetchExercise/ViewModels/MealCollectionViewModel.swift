//
//  

import UIKit

final class MealCollectionViewModel {
    private let networkManager: NetworkManager
    private let category: Category
    private var sortedMeals: [Meal] = []
    
    private var meals: [Meal] {
        didSet {
            let sortedMeals = self.meals.sorted { first, second in
                guard let firstName = first.name else { return true }
                guard let secondName = second.name else { return false }
                
                return firstName < secondName
            }
                        
            self.sortedMeals = sortedMeals
        }
    }
    
    init(category: Category, networkManager: NetworkManager = DefaultNetworkManager()) {
        self.networkManager = networkManager
        self.category = category
        self.meals = []
    }
    
    /// Gets the name of the category, if present. Otherwise gives a default value
    /// - Returns: String
    func getName() -> String {
        self.category.name ?? kCategory
    }
    
    /// Retrieves the meals content from the API
    /// - Parameter completion: (Error?) -> Void callback for the API call. Returns an Error if there was a problem. Otherwise returns nil
    func getContent(completion: @escaping (Error?) -> Void) {
        let categoryId = self.category.name ?? kMiscellaneous
        let api = MealAPI.mealList(categoryId: categoryId)
        self.networkManager.getData(from: api) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let meals = try JSONDecoder().decode(Meals.self, from: data)
                    self?.meals = meals.meals
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
    
    /// Gets the number of items for the collection view
    /// - Returns: Int
    func getNumberOfItems() -> Int {
        self.sortedMeals.count
    }
    
    /// Gets the size that each item should be to fill the available space with the given number of items per row.
    /// Takes into account the font and spacing for the cell
    /// - Parameters:
    ///   - spacing: CGFloat
    ///   - itemsPerRow: Int
    /// - Returns: CGSize
    func getItemSize(for spacing: CGFloat, itemsPerRow: Int) -> CGSize {
        let cgItemsPerRow = CGFloat(itemsPerRow)
        let interItemSpacing = spacing * (cgItemsPerRow - 1)
        let horizontalSpacing = spacing * 2
        let totalSpacing = horizontalSpacing + interItemSpacing
        
        let availableWidth = UIScreen.main.bounds.width - totalSpacing
        let width = availableWidth / cgItemsPerRow
        let height = width + MealCollectionViewCell.nameLabelFont.lineHeight + MealCollectionViewCell.nameLabelTopPadding
        
        return CGSize(width: width, height: height)
    }
    
    /// Gets the meal for a given index
    /// - Parameter index: IndexPath
    /// - Returns: Meal?
    func getMeal(for index: IndexPath) -> Meal? {
        let row = index.row
        guard row < self.sortedMeals.count else { return nil }
        
        return self.sortedMeals[row]
    }
}
