//
//  

import UIKit
import FetchExercise

final class MockImageCache: FetchExercise.ImageCache {
    private var image: UIImage?
    
    func cacheImage(_ image: UIImage, for urlString: String) {
        self.image = image
    }
    
    func getImage(for urlString: String) -> UIImage? {
        self.image
    }
}
