//
//  ClockAPIGeoNames.swift
//  SignupApp
//
//  Created by Américo Cantillo Gutiérrez on 8/08/21.
//

import Foundation
import CoreLocation

class ClockAPIGeoNames: ClockAPIService {
    
    private let urlAPIGeoNames = "http://api.geonames.org/timezoneJSON?formatted=true&lat={DeviceLatitude}&lng={DeviceLongitude}&username=qa_mobile_easy&style=full"
    
    var delegate: ClockAPIServiceDelegate?
    
    func fetchTimeFor(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (Result<ClockData, Error>) -> Void) {
        var url = urlAPIGeoNames.replacingOccurrences(of: "{DeviceLatitude}", with: String(latitude))
        url = url.replacingOccurrences(of: "{DeviceLongitude}", with: String(longitude))
        print("fetchTimeFor executing...")
        getTimeFrom(url: url) { [self] (result) in
            switch result {
            case .success(let clock):
                delegate?.didUpdateClockDataDelegate(clockData: clock)
                completion(.success(clock))
                print("fetchTimeFor after resume: \(clock.time)")
            case .failure(let error):
                self.delegate?.didFailAPIGeoNamesWithError(error: error)
                completion(.failure(error))
            }
        }
    }

    func getTimeFrom(url urlString: String, completion: @escaping (Result<ClockData, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                
                guard let data = data, error == nil else {
                    completion(.failure(error!))
                    return
                }

                var clock: ClockData?
                DispatchQueue.main.sync {
                    do {
                        clock = try JSONDecoder().decode(ClockData.self, from: data)
                        completion(.success(clock!))
                    } catch {
                        completion(.failure(error))
                    }
                }
            })
            task.resume()
        }
    }
}
