//
//  Extensions.swift
//  StarWarsInfo
//
//  Created by Miguel Cuellar on 03/09/21.
//

import UIKit

extension UIViewController {
    func displayResponse(message: String, title: String = "") {
        let alert = UIAlertController(title: title, message: message , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
