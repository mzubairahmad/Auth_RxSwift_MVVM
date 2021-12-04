//
//  UIViewController+Extensions.swift
//  Auth_RxSwift_MVVM
//
//  Created by Zubair Ahmad on 04/12/2021.
//

import UIKit

extension UIViewController {
    func showAlert(_ title: String, _ message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(.init(title: "OK", style: .default))
        self.present(alertController, animated: true)
    }
}
