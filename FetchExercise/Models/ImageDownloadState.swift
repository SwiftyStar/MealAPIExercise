//
//  

import UIKit

enum ImageDownloadState {
    case success(image: UIImage)
    case failure(error: Error?)
    case cancelled
}
