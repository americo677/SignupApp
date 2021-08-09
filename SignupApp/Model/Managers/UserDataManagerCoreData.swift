//
//  UserDataManagerCoreData.swift
//  SignupApp
//
//  Created by Américo Cantillo Gutiérrez on 6/08/21.
//

import Foundation
import CoreData

class UserDataManagerCoreData: UserDataManagerContract {
    
    let managedObjectContext: NSManagedObjectContext = CoreDataManager.shared.managedObjectContext!
    var contextLog: ActivityLogManagerContract?
    
    func fetchUserDataEntity(userData: UserData) -> UserDataEntity? {
        let fetchUserData: NSFetchRequest<UserDataEntity> = UserDataEntity.fetchRequest()
        fetchUserData.entity = NSEntityDescription.entity(forEntityName: "UserDataEntity", in: managedObjectContext)
        let predicate = NSPredicate(format: " email == %@ ", userData.email)
        fetchUserData.predicate = predicate

        do {
            let results = try managedObjectContext.fetch(fetchUserData)
            
            if !(results.count > 0) {
                return nil
            } else {
                return results.first!
            }
        } catch {
            let fetchError = error as NSError
            print(fetchError)
            return nil
        }
    }
    
    func validateUserData(userData: UserData, date: String) -> Int {
        
        contextLog = ActivityLogManagerCoreData()
        var activityLog: ActivityLogData?
        
        guard let entity = fetchUserDataEntity(userData: userData) else {
            return ValidationOutputCode.notFoundUserData
        }
        
        if ((entity.value(forKey: "password") as! String) != userData.password) {
            
            activityLog = ActivityLogData(date: date, result: "Acceso denegado", userData: userData)
            contextLog?.saveLog(activityLogData: activityLog!, userDataEntity: entity)
            return ValidationOutputCode.invalidUserPassword
            
        }
        
        activityLog = ActivityLogData(date: date, result: "Acceso otorgado", userData: userData)

        contextLog?.saveLog(activityLogData: activityLog!, userDataEntity: entity)

        return ValidationOutputCode.validUserData
        /*
        let fetchUserData: NSFetchRequest<UserDataEntity> = UserDataEntity.fetchRequest()
        fetchUserData.entity = NSEntityDescription.entity(forEntityName: "UserDataEntity", in: managedObjectContext)
        let predicate = NSPredicate(format: " email == %@ ", userData.email)
        fetchUserData.predicate = predicate
        
        

        do {
            let results = try managedObjectContext.fetch(fetchUserData)
            
            if !(results.count > 0) {
                return ValidationOutputCode.notFoundUserData
                // TODO: Implementar el registro de evento
            } else {
                if !(results.first!.value(forKey: "password") as! String == userData.password) {
                    return ValidationOutputCode.invalidUserPassword
                }
            }
        } catch {
            let fetchError = error as NSError
            print(fetchError)
            return ValidationOutputCode.fetchingError
        }
        return ValidationOutputCode.validUserData
         */
    }
    
    func signupUserData(userData: UserData) -> Int {
        var output = 0
        guard let _ = fetchUserDataEntity(userData: userData) else {
            output = signupNewUserData(userData: userData)
            return output
        }
        
        return SignupOutputCode.duplicated
    }
    
    func signupNewUserData(userData: UserData) -> Int {
        let entity = NSEntityDescription.entity(forEntityName: "UserDataEntity",
                                                in: managedObjectContext)!
        
        let userDataEntity = NSManagedObject(entity: entity,
                                     insertInto: managedObjectContext)
        
        userDataEntity.setValue(userData.email, forKey: "email")
        userDataEntity.setValue(userData.password, forKey: "password")
        userDataEntity.setValue(UUID().uuidString, forKey: "uid")
        
        do {
            try managedObjectContext.save()
            print("Data user stored sucessful.")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return SignupOutputCode.failed
        }
        return SignupOutputCode.success

    }
}
