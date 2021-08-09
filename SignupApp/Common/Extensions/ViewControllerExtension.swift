//
//  ViewControllerExtension.swift
//  SignupApp
//
//  Created by Américo Cantillo Gutiérrez on 7/08/21.
//

import Foundation
import UIKit

// MARK: - Common utils for UIViewController
extension UIViewController {
    
    // MARK: - Alerta personalizada
    func showCustomAlert(title: String, message strMessage: String, toFocus: UITextField?) {
        let alertController = UIAlertController(title: title, message:
                                                    strMessage, preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: { _ in
            
            if toFocus != nil {
                toFocus!.becomeFirstResponder()
            }
        })
        
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate implementation
extension UIViewController: UITextFieldDelegate {
    
    // MARK: - Para terminar la edición de un UITextField
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
