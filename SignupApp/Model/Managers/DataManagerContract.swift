//
//  DataManagerContract.swift
//  SignupApp
//
//  Created by Américo Cantillo Gutiérrez on 7/08/21.
//

import Foundation

struct ValidationOutputCode {
    static let validUserData = 0
    static let notFoundUserData = 1
    static let invalidUserPassword = 2
    static let fetchingError = -1
}

struct SignupOutputCode {
    static let success = 0
    static let failed = -1
    static let duplicated = -2
}

protocol DataManagerContract {
    
}
