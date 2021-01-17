//
//  AlertHelper.swift
//  iTunesSearcher
//
//  Created by Nikita Gundorin on 17.01.2021.
//

import UIKit

class AlertHelper {
    func presentAlert(vc: UIViewController?,
                      title: String,
                      message: String,
                      additionalActions: [UIAlertAction] = [],
                      primaryHandler: ((UIAlertAction) -> Void)? = nil) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(.init(title: "OK", style: .cancel, handler: primaryHandler))
            additionalActions.forEach { alertController.addAction($0) }
            vc?.present(alertController, animated: true)
        }
    }
    
    func presentErrorAlert(vc: UIViewController?,
                           message: String = "Some error occurred. Please try again later.",
                           handler: ((UIAlertAction) -> Void)? = nil) {
        presentAlert(vc: vc, title: "Error", message: message, primaryHandler: handler)
    }
}
