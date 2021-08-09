//
//  UserDataManagerTests.swift
//  SignupAppTests
//
//  Created by Américo Cantillo Gutiérrez on 8/08/21.
//

import XCTest
import CoreData

@testable import SignupApp

class UserDataManagerTests: XCTestCase {

    var managedContext: NSManagedObjectContext?
    
    var dataManager: UserDataManagerContract?
    
    var presenter: DataUserPresenterProtocol?
    
    var checker: ValidDataCheck?
    
    override func setUp() {
        super.setUp()

        presenter = UserDataManagerPresenter()
        
        managedContext = CoreDataManager.shared.managedObjectContext!
        
        dataManager = UserDataManagerCoreData()
        
        checker = ValidDataCheck()

        print("SQLite database: \(getPath("signupdb.sqlite"))")
    }
    
    override func tearDown() {
        checker = nil
        
        super.tearDown()
    }
    
    func testUserDataInsertOk() throws {
        var message: String = ""
        
        var userData = UserData(email: "americo677@dominio.com", password: "73Rzvzdv+")
        var result = presenter?.signup(userData: userData, message: &message)
        XCTAssertEqual(result, SignupOutputCode.success, message)

        userData = UserData(email: "americo677@gmail.com", password: "73Rzvzdv+")
        result = presenter?.signup(userData: userData, message: &message)
        XCTAssertEqual(result, SignupOutputCode.success, message)

        userData = UserData(email: "acantillo@empresa.com", password: "V73jvzdr0*")
        result = presenter?.signup(userData: userData, message: &message)
        XCTAssertEqual(result, SignupOutputCode.success, message)
    }
    
    func testSigninUserOk() throws {
        var userData = UserData(email: "americo677@gmail.com", password: "73Rzvzdv+")
        var result = presenter?.validate(userData: userData)
        XCTAssertEqual(result, ValidationOutputCode.validUserData, "Acceso otorgado \(userData.email).")
    }
    
    func testSigninUserNoOk() throws {
        var userData = UserData(email: "americo677@gmail.com", password: "73Rzvzdv34+")
        var result = presenter?.validate(userData: userData)
        XCTAssertEqual(result, ValidationOutputCode.notFoundUserData, "Acceso denegado \(userData.email).")
    }

    func testUserDataNotFound() throws {
        
        var userData = UserData(email: "americo677@midominio.com", password: "73Rzvzdv+")
        //var result = dataManager!.validateUserData(userData: userData)
        var result = presenter?.validate(userData: userData)
        
        XCTAssertEqual(result, ValidationOutputCode.notFoundUserData, "Cuenta de correo \(userData.email) NO está registrada.")

        userData = UserData(email: "americo.cantillo@hotmail.com", password: "nomeacuerdo")
        //result = dataManager!.validateUserData(userData: userData)
        result = presenter?.validate(userData: userData)
        XCTAssertEqual(result, ValidationOutputCode.notFoundUserData, "Cuenta de correo \(userData.email) está registrada.")
    }

    func testUserDataFoundPasswordMatch() throws {
        
        var userData = UserData(email: "americo677@gmail.com", password: "73Rzvzdv+")
        
        var result = presenter?.validate(userData: userData)
        
        XCTAssertEqual(result, ValidationOutputCode.validUserData, "Cuenta de correo \(userData.email) NO está registrada.")

        /*
         var userData = UserData(email: "americo677@gmail.com", password: "73Rzvzdv+")
         var result = dataManager!.validateUserData(userData: userData)
         XCTAssertEqual(result, ValidationOutputCode.validUserData, "Cuenta de correo \(userData.email) NO está registrada.")

         userData = UserData(email: "americo677@domain.com", password: "1234567")
        result = dataManager!.validateUserData(userData: userData)
        XCTAssertEqual(result, ValidationOutputCode.validUserData, "Cuenta de correo \(userData.email) NO está registrada.")

        userData = UserData(email: "americo677@gmail.com", password: "1234567")
        result = dataManager!.validateUserData(userData: userData)
        XCTAssertEqual(result, ValidationOutputCode.validUserData, "Cuenta de correo \(userData.email) NO está registrada.")

        userData = UserData(email: "americo.cantillo@gmail.com", password: "nomeacuerdo")
        result = dataManager!.validateUserData(userData: userData)
        XCTAssertEqual(result, ValidationOutputCode.validUserData, "Cuenta de correo \(userData.email) está registrada.")
 */
    }
    
    func testUserDataFoundPasswordNoMatch() throws {
        
        var userData = UserData(email: "americo677@dominio.com", password: "anotherPassword")
        var result = presenter?.validate(userData: userData)
        
        XCTAssertEqual(result, ValidationOutputCode.invalidUserPassword, "Cuenta de correo \(userData.email) NO está registrada.")

        userData = UserData(email: "americo677@gmail.com", password: "anotherpasswordtoo")
        result = presenter?.validate(userData: userData)
        XCTAssertEqual(result, ValidationOutputCode.invalidUserPassword, "Cuenta de correo \(userData.email) NO está registrada.")
    }

    func testValidEmail() throws {
        var email: String = ""
        var result: Bool = false
        
        email = "americo677@gmail.com"
        result = checker!.isValidEMail(email: email)
        XCTAssertTrue(result, "Cuenta de correo \(email) es válida.")

        email = "americo677@gmail.com.co"
        result = checker!.isValidEMail(email: email)
        XCTAssertTrue(result, "Cuenta de correo \(email) NO es válida.")

        email = "americo677@hotmail.co"
        result = checker!.isValidEMail(email: email)
        XCTAssertTrue(result, "Cuenta de correo \(email) es válida.")
    }

    func testNotValidEmail() throws {

        var email: String = ""
        var result: Bool = false

        email = "americo677gmail.com"
        result = checker!.isValidEMail(email: email)
        XCTAssertFalse(result, "Cuenta de correo \(email) NO es válida.")

        email = "americo677@gmailcom"
        result = checker!.isValidEMail(email: email)
        XCTAssertFalse(result, "Cuenta de correo \(email) NO es válida.")

    }
    
    func testPasswordNoValid() throws {
        var password = ""

        password = "1234"
        XCTAssertFalse(checker!.isValidPassword(password: password))
        
        password = "1234567"
        XCTAssertFalse(checker!.isValidPassword(password: password))

        password = "12345678"
        XCTAssertFalse(checker!.isValidPassword(password: password))

        password = "12345678A"
        XCTAssertFalse(checker!.isValidPassword(password: password))

        password = "1234*5678A"
        XCTAssertFalse(checker!.isValidPassword(password: password))

        password = "nomeacuerdo+"
        XCTAssertFalse(checker!.isValidPassword(password: password))

        password = "nomeAcuerdo+"
        XCTAssertFalse(checker!.isValidPassword(password: password))
    }
    
    func testPasswordValid() throws {
        var password = ""
        
        password = "nomeAcuerd0+"
        XCTAssertTrue(checker!.isValidPassword(password: password))

        password = "1s234*5678A"
        XCTAssertTrue(checker!.isValidPassword(password: password))

        password = "paS$wo7d*"
        XCTAssertTrue(checker!.isValidPassword(password: password))

        password = "paS$w0rd|%"
        XCTAssertTrue(checker!.isValidPassword(password: password))
    }

}

func getPath(_ fileName: String) -> String {
    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let fileURL = documentsURL.appendingPathComponent(fileName)
    return fileURL.path
}
