//
//  UIViewController+Additions.swift
//  leBaluchon
//
//  Created by Christophe Expleo on 17/09/2021.
//

import UIKit

extension UIViewController {
    func presentAlert(error: String) {
        let alert = UIAlertController(title: "Erreur", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
