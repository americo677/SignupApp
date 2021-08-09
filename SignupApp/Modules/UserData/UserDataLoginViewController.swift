//
//  UserDataLoginViewController.swift
//  SignupApp
//
//  Created by Américo Cantillo Gutiérrez on 6/08/21.
//

import UIKit
import CoreLocation

protocol UserDataManagerViewProtocol: class {
    var presenter: DataUserPresenterProtocol? { get set }
}

class UserDataLoginViewController: UIViewController, UserDataManagerViewProtocol {

    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    var presenter: DataUserPresenterProtocol?
    
    let locationManager = CLLocationManager()
    
    var clockTime: ClockData?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter = UserDataManagerPresenter()
        presenter?.view = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        // Start updating location
        locationManager.startUpdatingLocation()

        // Make sure to stop updating location when your
        // app no longer needs location updates
        //locationManager.stopUpdatingLocation()
        
        print("SQLite database: \(getPath("signupdb.sqlite"))")
        
        //let lat: CLLocationDegrees = 4.71
        //let lon: CLLocationDegrees = -74.07
        
    }
    
    func getPath(_ fileName: String) -> String {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(fileName)
        return fileURL.path
    }

    @IBAction func buttonTouchUpInside(_ sender: UIButton) {
        
        guard let email = self.emailTextField.text else { return }
        
        guard let password = self.passwordTextField.text else { return }
        
        let userData = UserData(email: email, password: password)

        if (sender.titleLabel!.text == "Sign In") {

            locationManager.requestLocation()

            let result = self.presenter?.validate(userData: userData)
            
            if (result == 0) {
                print("Email \(email) validado con éxito.  Resultado de validación: exitoso.")
            }
            
        } else if (sender.titleLabel!.text == "Sign Up") {
            var mensaje = ""
            
            let result = self.presenter?.signup(userData: userData, message: &mensaje)
            
            if (result != SignupOutputCode.success) {
                showCustomAlert(title: "Signup", message: mensaje, toFocus: emailTextField)
            }
            
            print("\(mensaje)")
            
        } else {
            // do something else
            print("No button pressed")
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - CLLocationManagerDelegate
extension UserDataLoginViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            self.presenter?.latitude = location.coordinate.latitude
            self.presenter?.longitude = location.coordinate.longitude
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension UserDataLoginViewController: ClockAPIServiceDelegate {

    func didUpdateClockDataDelegate(clockData: ClockData?) {
        DispatchQueue.main.async {
            //self.clockTime = clockData as? ClockData
            //self.presenter?.interactor?.clockData = self.clockTime
            print("printed from didUpdateClockDataDelegate: \(clockData!.time)")
        }
    }
        
    func didFailAPIGeoNamesWithError(error: Error) {
        print(error)
    }
}
