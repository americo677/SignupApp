//
//  ActivityLogManagerCoreData.swift
//  SignupApp
//
//  Created by Américo Cantillo Gutiérrez on 9/08/21.
//

import Foundation
import CoreData

class ActivityLogManagerCoreData: ActivityLogManagerContract {

    let managedObjectContext: NSManagedObjectContext = CoreDataManager.shared.managedObjectContext!
    var userDataManager: UserDataManagerContract?
    
    init() {
        userDataManager = UserDataManagerCoreData()
    }
    
    
    func saveLog(activityLogData: ActivityLogData, userDataEntity: UserDataEntity) {
        let entity = NSEntityDescription.entity(forEntityName: "ActivityLogEntity",
                                                in: managedObjectContext)!
        
        let activityLogEntity = NSManagedObject(entity: entity,
                                     insertInto: managedObjectContext)
        
        activityLogEntity.setValue(activityLogData.date, forKey: "date")
        activityLogEntity.setValue(activityLogData.result, forKey: "result")
        activityLogEntity.setValue(userDataEntity, forKey: "userdata")
        
        do {
            try managedObjectContext.save()
            print("activity log stored sucessful.")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getLog(userData: UserData) -> [ActivityLogEntity]? {
        guard let entity = userDataManager?.fetchUserDataEntity(userData: userData) else {
            return nil
        }

        let fetchActivityLogData: NSFetchRequest<ActivityLogEntity> = ActivityLogEntity.fetchRequest()
        fetchActivityLogData.entity = NSEntityDescription.entity(forEntityName: "ActivityLogEntity", in: managedObjectContext)
        let predicate = NSPredicate(format: " userdata == %@ ", entity)
        fetchActivityLogData.predicate = predicate

        do {
            let results = try managedObjectContext.fetch(fetchActivityLogData)
            
            if !(results.count > 0) {
                return nil
            } else {
                return results
            }
        } catch {
            let fetchError = error as NSError
            print(fetchError)
            return nil
        }
    }
}
