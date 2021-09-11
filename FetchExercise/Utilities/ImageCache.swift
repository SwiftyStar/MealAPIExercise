//
//

import UIKit

protocol ImageCache {
    func cacheImage(_ image: UIImage, for urlString: String)
    func getImage(for urlString: String) -> UIImage?
}

final class DefaultImageCache: ImageCache {
    static let shared = DefaultImageCache()
    private let cache = NSCache<NSString, UIImage>()

    private init() { }
    
    /// Caches the image in relation to the URL used to retrieve it
    /// - Parameters:
    ///   - image: UIImage
    ///   - urlString: String
    func cacheImage(_ image: UIImage, for urlString: String) {
        self.cache.setObject(image, forKey: NSString(string: urlString))
    }
    
    /// Gets the image associated with the URl, if any
    /// - Parameter urlString: String
    /// - Returns: UIImage?
    func getImage(for urlString: String) -> UIImage? {
        return self.cache.object(forKey: NSString(string: urlString))
    }
}
