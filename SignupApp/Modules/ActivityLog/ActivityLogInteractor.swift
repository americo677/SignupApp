//
//  ActivityLogInteractor.swift
//  SignupApp
//
//  Created by Américo Cantillo Gutiérrez on 9/08/21.
//

import Foundation

protocol ActivityLogManagerInteractorProtocol: class {
    
    var context: ActivityLogManagerContract? { get set }
    func getLog(userData: UserData) -> [ActivityLogData]?
}


class ActivityLogInteractor: ActivityLogManagerInteractorProtocol {

    var context: ActivityLogManagerContract?
    
    init() {
        context = ActivityLogManagerCoreData()
    }

    func getLog(userData: UserData) -> [ActivityLogData]? {
        
        var activityLog: ActivityLogData?
        
        var logs = [ActivityLogData]()
        
        let activityLogFetched = context?.getLog(userData: userData)
        
        for activityLogFetch in activityLogFetched! {
            
            let eventTime: String = activityLogFetch.value(forKey: "date") as! String
            let result: String = activityLogFetch.value(forKey: "result") as! String
            
            activityLog = ActivityLogData(date: eventTime, result: result, userData: userData)
            
            logs.append(activityLog!)
        }
        return logs
    }
}
