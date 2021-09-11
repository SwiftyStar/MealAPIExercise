//
//  

import UIKit

final class MealCollectionViewCellViewModel {
    private let networkManager: NetworkManager
    private let imageCache: ImageCache
    private var currentURLTask: URLSessionDataTask?
    
    init(imageCache: ImageCache = DefaultImageCache.shared, networkManager: NetworkManager = DefaultNetworkManager()) {
        self.networkManager = networkManager
        self.imageCache = imageCache
    }
    
    /// Gets the name of the meal if present. Otherwise returns a default value
    /// - Parameter meal: Meal?
    /// - Returns: String
    func getName(for meal: Meal?) -> String {
        meal?.name ?? kMeal
    }
    
    /// Downloads the image for the given meal
    /// - Parameters:
    ///   - category: Meal?
    ///   - completion: (UIImage?) -> Void
    func downloadImage(for meal: Meal?, completion: @escaping (UIImage?) -> Void) {
        guard let imageURLString = meal?.imageURLString,
              let imageURL = URL(string: imageURLString)
        else {
            self.handleImageFailure(completion: completion)
            return
        }
        
        if let cachedImage = self.imageCache.getImage(for: imageURLString) {
            completion(cachedImage)
            return
        }
                
        let task = self.networkManager.getData(from: imageURL) { [weak self] result in
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

        self.currentURLTask = task
    }
    
    /// Cancels any current download
    func cancelDownload() {
        self.currentURLTask?.cancel()
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
