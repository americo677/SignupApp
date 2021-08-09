//
//  ActivityLogManagerTests.swift
//  SignupAppTests
//
//  Created by Américo Cantillo Gutiérrez on 9/08/21.
//

import XCTest

@testable import SignupApp

class ActivityLogManagerTests: XCTestCase {

    var interactor:  ActivityLogManagerInteractorProtocol?

    override func setUp() {
        super.setUp()
        
        interactor = ActivityLogInteractor()
        
    }
    
    override func tearDown() {
        interactor = nil
        
        super.tearDown()
    }
    
    func testListActivityLogOk() throws {
        
        var email = "americo677@gmail.com"
        var password = "73Rzvzdv+"
        var userData = UserData(email: email, password: password)
        
        let logs = interactor?.getLog(userData: userData)
        
        XCTAssertNotNil(logs!, "Resultado debería retornar registros.")
        XCTAssert(logs!.count > 0, "Listado de registros de la bitácora de validación de una cuenta.")
    }

}
