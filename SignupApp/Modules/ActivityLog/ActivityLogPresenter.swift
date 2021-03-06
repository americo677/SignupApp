//
//  ActivityLogManagerPresenter.swift
//  SignupApp
//
//  Created by Américo Cantillo Gutiérrez on 9/08/21.
//

import Foundation

protocol ActivityLogPresenterProtocol: class {
    
    var interactor: ActivityLogManagerInteractorProtocol? { get set }
    var view: ActivityLogManagerViewProtocol? { get set }
    var activityLogs: [ActivityLogData]? { get set }
    var userData: UserData? { get set }

    func getLog(userData: UserData) -> [ActivityLogData]?
}


class ActivityLogPresenter: ActivityLogPresenterProtocol {
    var interactor: ActivityLogManagerInteractorProtocol?
    
    var view: ActivityLogManagerViewProtocol?
    
    var activityLogs: [ActivityLogData]?
    
    var userData: UserData?
    
    init() {
        interactor = ActivityLogInteractor()
        activityLogs = [ActivityLogData]()
    }
    
    func getLog(userData: UserData) -> [ActivityLogData]? {
        self.userData = userData
        self.activityLogs = interactor?.getLog(userData: userData)
        return self.activityLogs
    }
    
    
}
