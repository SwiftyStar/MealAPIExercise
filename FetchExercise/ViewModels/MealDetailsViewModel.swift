//
//  

import UIKit

final class MealDetailsViewModel {
    private let meal: Meal
    private let networkManager: NetworkManager
    private let imageCache: ImageCache
    private var mealDetail: MealDetail?
    private var ingredients: [Ingredient] = []
    
    init(meal: Meal, networkManager: NetworkManager = DefaultNetworkManager(), imageCache: ImageCache = DefaultImageCache.shared) {
        self.meal = meal
        self.networkManager = networkManager
        self.imageCache = imageCache
    }
    
    /// Retrieves the meal details content from the API
    /// - Parameter completion: (Error?) -> Void callback for the API call. Returns an Error if there was a problem. Otherwise returns nil
    func getContent(completion: @escaping (Error?) -> Void) {
        let api = MealAPI.mealDetails(mealId: self.meal.id ?? "1")
        self.networkManager.getData(from: api) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let mealDetails = try JSONDecoder().decode(MealDetails.self, from: data)
                    let mealDetail = mealDetails.meals.first
                    self?.mealDetail = mealDetail
                    self?.getIngredients(from: mealDetail)
                    self?.handleSuccess(completion: completion)
                } catch {
                    self?.handleFailure(error: error, completion: completion)
                }
            case .failure(let error):
                self?.handleFailure(error: error, completion: completion)
            }
        }
    }
    
    private func getIngredients(from detail: MealDetail?) {
        guard let detail = detail else { return }
        
        var ingredients: [Ingredient] = []
        
        (1...20).forEach { index in
            let ingredientNameKey = "\(kIngredientName)\(index)"
            let ingredientMeasureKey = "\(kIngredientMeasure)\(index)"
            
            guard let ingredientName = detail.value(forKey: ingredientNameKey) as? String,
                  !ingredientName.isEmpty,
                  let ingredientMeasure = detail.value(forKey: ingredientMeasureKey) as? String,
                  !ingredientMeasure.isEmpty
            else { return }
            
            let ingredient = Ingredient(name: ingredientName, measurement: ingredientMeasure)
            ingredients.append(ingredient)
        }
        
        self.ingredients = ingredients
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
    
    /// Gets the array of ingredients
    /// - Returns: [Ingredient]
    func getIngredients() -> [Ingredient] {
        self.ingredients
    }
    
    /// Gets the name of the meal
    /// - Returns: String?
    func getName() -> String? {
        self.meal.name
    }
    
    /// Gets the description of the meal
    /// - Returns: String?
    func getDescription() -> String? {
        self.mealDetail?.description
    }
    
    /// Gets the source URL, if available and valid
    /// - Returns: URL?
    func getSourceURL() -> URL? {
        guard let urlString = self.mealDetail?.sourceURLString else { return nil }
        
        return URL(string: urlString)
    }
    
    /// Gets the YouTube URL, if available and valid
    /// - Returns: URL?
    func getYoutubeURL() -> URL? {
        guard let urlString = self.mealDetail?.youtubeURLString else { return nil}
        
        return URL(string: urlString)
    }
    
    /// Gets the instructions for preparing the meal
    /// - Returns: String?
    func getInstructions() -> String? {
        self.mealDetail?.instructions
    }
    
    /// Downloads the image for the given meal
    /// - Parameters:
    ///   - completion: (UIImage?) -> Void
    func downloadImage(completion: @escaping (UIImage?) -> Void) {
        guard let imageURLString = self.mealDetail?.imageURLString,
              let imageURL = URL(string: imageURLString)
        else {
            self.handleImageFailure(completion: completion)
            return
        }
        
        if let cachedImage = self.imageCache.getImage(for: imageURLString) {
            completion(cachedImage)
            return
        }
                
        self.networkManager.getData(from: imageURL) { [weak self] result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                
                self?.imageCache.cacheImage(image, for: imageURLString)
                self?.handleImageSuccess(image: image, completion: completion)
            case .failure:
                self?.handleImageFailure(completion: completion)
            }
        }
    }
    
    private func handleImageSuccess(image: UIImage, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.main.async {
            completion(image)
        }
    }
    
    private func handleImageFailure(completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.main.async {
            completion(nil)
        }
    }
}
