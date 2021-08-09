//
//  UserDataPresenter.swift
//  SignupApp
//
//  Created by Américo Cantillo Gutiérrez on 7/08/21.
//

import Foundation
import CoreLocation

struct UserInputValidationCode {
    static let isValid = 0
    static let invalidEmail = 1
    static let invalidPassword = 2
}

// MARK: - Interactor input: Presenter -> Interactor
protocol DataUserPresenterProtocol: class {
    
    var interactor: UserDataManagerInteractorProtocol? { get set }
    var view: UserDataManagerViewProtocol? { get set }
    var latitude: CLLocationDegrees? { get set }
    var longitude: CLLocationDegrees? { get set }
    var userData: UserData? { get set }

    func validate(userData: UserData) -> Int
    func signup(userData: UserData, message: inout String) -> Int
}

class UserDataManagerPresenter: DataUserPresenterProtocol {
    
    var interactor: UserDataManagerInteractorProtocol?
    
    var checker: ValidDataCheckContract?
    
    var view: UserDataManagerViewProtocol?
    
    // init by default, but is setting in view at locationManager(:didUpdateLocations)
    var latitude: CLLocationDegrees? = 4.71
    // init by default, but is setting in view at locationManager(:didUpdateLocations)
    var longitude: CLLocationDegrees? = -74.07

    var userData: UserData?
    
    init() {
        interactor = UserDataInteractor()
        checker = ValidDataCheck()
    }
    
    func validate(userData: UserData) -> Int {
        interactor?.fetchDataTime(latitude: self.latitude!, longitude: self.longitude!)
        let result = self.interactor?.validateUserData(userData: userData)
        return result!
    }
    
    func checkUserInput(userData: UserData, message: inout String) -> Int {
        if !((checker?.isValidEMail(email: userData.email))!) {
            message = "La cuenta de correo no es válida.  Por favor verifica."
            return UserInputValidationCode.invalidEmail
        }
        
        if !(checker!.isValidPassword(password: userData.password)) {
            message = "El password debe tener mínimo 8 carácteres, minúsculas, mayúculas, números y caracteres especiales.  Por favor verifica."
            return UserInputValidationCode.invalidPassword
        }
        
        return UserInputValidationCode.isValid
    }
    
    func signup(userData: UserData, message: inout String) -> Int {
        var checkResult: Int = 0
        var result: Int = 0
        
        message = "Cuenta registrada con éxito."
        
        checkResult = checkUserInput(userData: userData, message: &message)
        
        if (checkResult == UserInputValidationCode.isValid) {
            result = (self.interactor?.signupUserData(userData: userData))!
        } else {
            result = checkResult
        }
        
        switch result {
        case SignupOutputCode.duplicated:
            message = "La cuenta ya se encuentra registrada."
            break
        case SignupOutputCode.failed:
            message = "No se pudo registrar la cuenta."
            break
        default:
            break
        }
        
        return result
    }
    
}
