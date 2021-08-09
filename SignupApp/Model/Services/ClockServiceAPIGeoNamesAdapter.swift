//
//  ClockServiceAPIGeoNamesAdapter.swift
//  SignupApp
//
//  Created by Américo Cantillo Gutiérrez on 8/08/21.
//

import Foundation

enum ClockServiceAPIError: Error {
    case noFetchTime
}

class ClockServiceAPIGeoNamesAdapter: ClockServiceContract {
    
    func getTime() throws -> String {
        var result: String = ""
        
        return result
    }
    
}
