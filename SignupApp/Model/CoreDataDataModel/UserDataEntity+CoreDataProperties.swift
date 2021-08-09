//
//  UserDataEntity+CoreDataProperties.swift
//  SignupApp
//
//  Created by Américo Cantillo Gutiérrez on 7/08/21.
//
//

import Foundation
import CoreData


extension UserDataEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserDataEntity> {
        return NSFetchRequest<UserDataEntity>(entityName: "UserDataEntity")
    }

    @NSManaged public var password: String?
    @NSManaged public var email: String?
    @NSManaged public var uid: String?
    @NSManaged public var activitylog: NSSet?

}

// MARK: Generated accessors for activitylog
extension UserDataEntity {

    @objc(addActivitylogObject:)
    @NSManaged public func addToActivitylog(_ value: ActivityLogEntity)

    @objc(removeActivitylogObject:)
    @NSManaged public func removeFromActivitylog(_ value: ActivityLogEntity)

    @objc(addActivitylog:)
    @NSManaged public func addToActivitylog(_ values: NSSet)

    @objc(removeActivitylog:)
    @NSManaged public func removeFromActivitylog(_ values: NSSet)

}

extension UserDataEntity : Identifiable {

}
