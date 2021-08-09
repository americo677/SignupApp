//
//  UserDataManagerContract.swift
//  SignupApp
//
//  Created by Américo Cantillo Gutiérrez on 6/08/21.
//

import Foundation

protocol UserDataManagerContract: class {
    func fetchUserDataEntity(userData: UserData) -> UserDataEntity?
    func validateUserData(userData: UserData, date: String) -> Int
    func signupUserData(userData: UserData) -> Int
}
