//
//  

import UIKit

final class CategoryCellViewModel {
    private let networkManager: NetworkManager
    private let imageCache: ImageCache
    private var currentURLTask: URLSessionDataTask?
    
    init(imageCache: ImageCache = DefaultImageCache.shared, networkManager: NetworkManager = DefaultNetworkManager()) {
        self.networkManager = networkManager
        self.imageCache = imageCache
    }
    /// Gets the name of the category if present. Otherwise returns a default value
    /// - Parameter category: Category?
    /// - Returns: String
    func getName(for category: Category?) -> String {
        category?.name ?? kCategory
    }
    
    /// Gets the description of the category if present. Otherwise returns a default value
    /// - Parameter category: Category?
    /// - Returns: String
    func getDescription(for category: Category?) -> String {
        category?.description ?? kDescription
    }
    
    /// Downloads the image for the given category
    /// - Parameters:
    ///   - category: Category?
    ///   - completion: (UIImage?) -> Void
    func downloadImage(for category: Category?, completion: @escaping (UIImage?) -> Void) {
        guard let imageURLString = category?.imageURLString,
              let imageURL = URL(string: imageURLString)
        else {
            self.handleImageFailure(completion: completion)
            return
        }
        
        if let cachedImage = self.imageCache.getImage(for: imageURLString) {
            self.handleImageSuccess(image: cachedImage, completion: completion)
            return
        }
        
        let task = self.networkManager.getData(from: imageURL) { [weak self] result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    self?.handleImageFailure(completion: completion)
                    return
                }
                
                self?.imageCache.cacheImage(image, for: imageURLString)
                self?.handleImageSuccess(image: image, completion: completion)
            case .failure(let error):
                self?.handleImageFailure(error: error, completion: completion)
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
    
    private func handleImageFailure(error: Error? = nil, completion: @escaping (UIImage?) -> Void) {
        if let urlError = error as? URLError,
           urlError.code == .cancelled {
            return
        }
        
        DispatchQueue.main.async {
            completion(nil)
        }
    }
}
