//
//  

import UIKit

class BaseViewController: UIViewController {
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    /// Shows the activity indicator if it is not already showing
    func showActivityIndicator() {
        guard self.activityIndicator.superview == nil else { return }
        
        // Should have some logic to be sure the activity indicator is on the top of the view hierarchy
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator
            .centerYAnchor
            .constraint(equalTo: self.view.centerYAnchor)
            .isActive = true
        self.activityIndicator
            .centerXAnchor
            .constraint(equalTo: self.view.centerXAnchor)
            .isActive = true
        
        self.activityIndicator.startAnimating()
    }
    
    /// Hides the activity indicator
    func hideActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.removeFromSuperview()
    }
}
