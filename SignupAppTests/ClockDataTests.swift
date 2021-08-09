//
//  ClockDataTests.swift
//  SignupAppTests
//
//  Created by Américo Cantillo Gutiérrez on 8/08/21.
//

import XCTest
import CoreLocation

@testable import SignupApp

class ClockDataTests: XCTestCase {

    //var presenter: DataUserManagerPresenterProtocol?
    var interactor:  UserDataManagerInteractorProtocol?
    var api: ClockAPIGeoNames?
    
    override func setUp() {
        super.setUp()
        
        interactor = UserDataInteractor()
        
        api = ClockAPIGeoNames()

    }
    
    override func tearDown() {
        //presenter = nil
        //interactor = nil
        api = nil
        
        super.tearDown()
    }
    
    func testfetchClockData() throws {
        let lat: CLLocationDegrees = 4.71
        let lon: CLLocationDegrees = -74.07

        //XCTAssertNoThrow(api!.fetchFor(latitude: lat, longitude: lon), "Throws error)

     }
    
}
