//
//  Gender+CoreDataProperties.swift
//  CoreDataMigrationPractice
//
//  Created by 정성훈 on 2022/01/18.
//
//

import Foundation
import CoreData


extension Gender {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Gender> {
        return NSFetchRequest<Gender>(entityName: "Gender")
    }

    @NSManaged public var type: String?
    @NSManaged public var users: NSSet?

}

// MARK: Generated accessors for users
extension Gender {

    @objc(addUsersObject:)
    @NSManaged public func addToUsers(_ value: User)

    @objc(removeUsersObject:)
    @NSManaged public func removeFromUsers(_ value: User)

    @objc(addUsers:)
    @NSManaged public func addToUsers(_ values: NSSet)

    @objc(removeUsers:)
    @NSManaged public func removeFromUsers(_ values: NSSet)

}

extension Gender : Identifiable {

}
