//
//  UserDataManagerInteractor.swift
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
    func fetchDataTime(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> String
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
    
    func fetchDataTime(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> String {
        var time: String = ""
        
        clockManager?.fetchTimeFor(latitude: latitude, longitude: longitude) { (result) in
            switch result {
            case .success(let clock):
                // Parse your Json: I call a function Parse that does it
                //success(clock.time)
                //delegate?.didUpdateClockDataDelegate(clockData: clock)
                time = clock.time
                self.eventTime = clock.time
                print("fetchTimeFor from iterator: \(clock.time)")
            case .failure(let error):
                //failure(error)
                //self.delegate?.didFailAPIGeoNamesWithError(error: error)
                //break
                print(error)
            }
            
        }

        /*
        (clockManager?.fetchTimeFor(latitude: latitude, longitude: longitude, success: { date in
            print("printed from interactor.fetchDataTime: \(date)" )
            time = date
        }, failure: { error in
            print(error)
        }))!
 */
        //self.eventTime = time
        return time
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
