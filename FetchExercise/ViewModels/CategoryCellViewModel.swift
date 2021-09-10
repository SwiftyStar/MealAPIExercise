//
//  

import UIKit

struct CategoryCellViewModel {
    
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
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let data = try? Data(contentsOf: imageURL),
                  let image = UIImage(data: data)
            else {
                self.handleImageFailure(completion: completion)
                return
            }
            
            self.handleImageSuccess(image: image, completion: completion)
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
