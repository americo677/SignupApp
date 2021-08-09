//
//  ActivityLogManagerContract.swift
//  SignupApp
//
//  Created by Américo Cantillo Gutiérrez on 9/08/21.
//

import Foundation

protocol ActivityLogManagerContract: class {
    func saveLog(activityLogData: ActivityLogData, userDataEntity: UserDataEntity)
    func getLog(userData: UserData) -> [ActivityLogEntity]?
}
