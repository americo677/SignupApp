//
//  ActivityLogEntity+CoreDataProperties.swift
//  SignupApp
//
//  Created by Américo Cantillo Gutiérrez on 9/08/21.
//
//

import Foundation
import CoreData


extension ActivityLogEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActivityLogEntity> {
        return NSFetchRequest<ActivityLogEntity>(entityName: "ActivityLogEntity")
    }

    @NSManaged public var date: String?
    @NSManaged public var result: String?
    @NSManaged public var userdata: UserDataEntity?

}

extension ActivityLogEntity : Identifiable {

}
