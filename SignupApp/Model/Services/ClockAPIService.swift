//
//  ClockAPIService.swift
//  SignupApp
//
//  Created by Américo Cantillo Gutiérrez on 8/08/21.
//

import Foundation
import CoreData


protocol ClockAPIServiceDelegate: class {
    func didUpdateClockDataDelegate(clockData: ClockData?)
    func didFailAPIGeoNamesWithError(error: Error)
}

protocol ClockAPIService: class {
    func fetchTimeFor(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (Result<ClockData, Error>) -> Void)

    func getTimeFrom(url urlString: String, completion: @escaping (Result<ClockData, Error>) -> Void)
}
