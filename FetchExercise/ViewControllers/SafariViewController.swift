//
//  

import UIKit
import SafariServices

final class SafariViewController: SFSafariViewController {
    override init(url URL: URL, configuration: SFSafariViewController.Configuration = .init()) {
        super.init(url: URL, configuration: configuration)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
