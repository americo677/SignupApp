//
//  ValidDataCheckContract.swift
//  SignupApp
//
//  Created by Américo Cantillo Gutiérrez on 7/08/21.
//

import Foundation

protocol ValidDataCheckContract {
    func isValidEMail(email: String) -> Bool
    func isValidPassword(password: String) -> Bool
}
