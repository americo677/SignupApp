//
//  ValidDataCheck.swift
//  SignupApp
//
//  Created by Américo Cantillo Gutiérrez on 7/08/21.
//

import Foundation

class ValidDataCheck: ValidDataCheckContract {
    
    func isValidEMail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(password: String) -> Bool {
        let pwsRegEx = "^(?=.*[a-z])(?=.*[0-9])(?=.*[$@$#!%\\*?&+-_])(?=.*[A-Z]).{8,}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@ ", pwsRegEx)
        return passwordPred.evaluate(with: password)
    }
}
