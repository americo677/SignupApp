//
//  UserDataInteractor.swift
//  SignupApp
//
//  Created by Américo Cantillo Gutiérrez on 7/08/21.
//

import Foundation
import CoreLocation

// MARK: - Interactor view input: Interactor -> BusinessLogic
protocol UserDataManagerInteractorProtocol: class {
    
    var context: UserDataManagerContract? { get set }
    var clockManager: ClockAPIService? { get set }
    var eventTime: String? { get set }

    func validateUserData(userData: UserData) -> Int
    func signupUserData(userData: UserData) -> Int
    func fetchDataTime(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
}

class UserDataInteractor: UserDataManagerInteractorProtocol {
    
    var context: UserDataManagerContract?
    var clockManager: ClockAPIService?
    var eventTime: String?
    
    init() {
        context = UserDataManagerCoreData()
        clockManager = ClockAPIGeoNames()
        eventTime = ""
    }
    
    func validateUserData(userData: UserData) -> Int {
        var result = 0
        result = (context?.validateUserData(userData: userData, date: self.eventTime!))!
        return result
    }
    
    func signupUserData(userData: UserData) -> Int {
        var result = 0
        result = (context?.signupUserData(userData: userData))!
        return result
    }
    
    func fetchDataTime(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        clockManager?.fetchTimeFor(latitude: latitude, longitude: longitude) { [self] (result) in
            switch result {
            case .success(let clock):
                eventTime = clock.time
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}

// MARK: - ClockAPIServiceDelegate
extension UserDataInteractor: ClockAPIServiceDelegate {
    
    func didUpdateClockDataDelegate(clockData: ClockData?) {
        DispatchQueue.main.sync {
            self.eventTime = clockData?.time
            print("didUpdateClockDataDelegate clock time is: \(self.eventTime!)")
        }
    }
    
    func didFailAPIGeoNamesWithError(error: Error) {
        print("Error inesperado al refrescar la hora con el API: \(error.localizedDescription)")
    }
}
