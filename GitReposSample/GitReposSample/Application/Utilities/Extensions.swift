//
//  Extensions.swift
//  GitReposSample
//
//  Created by Blue Peak Systems on 9/7/21.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(_ message: String) {
        let alert = UIAlertController.init(title: "Info", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension UIView {
    func startActivityIndicator(_ interactionEnabled: Bool = false) {
        let activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.color = .gray
        activityIndicator.tag = 100
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = interactionEnabled
        addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    func stopActivityIndicator() {
        isUserInteractionEnabled = true
        if let activityIndicator = viewWithTag(100) as? UIActivityIndicatorView {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
}

extension String {
    var urlEncoded: String { return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! }
}
extension Optional where Wrapped == String {
    var defaultUnwrapped: String {
        return self ?? ""
    }
}
