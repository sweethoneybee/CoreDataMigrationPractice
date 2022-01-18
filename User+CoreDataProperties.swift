//
//  User+CoreDataProperties.swift
//  CoreDataMigrationPractice
//
//  Created by 정성훈 on 2022/01/18.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
//    @NSManaged public var sex: String?
    @NSManaged public var gender: Gender?

    var wrappedName: String {
        name ?? "Unknown name"
    }
    
    var wrappedGenderName: String {
//        sex ?? "Unknown sex"
        gender?.value(forKey: "type") as? String ?? "Unknown sex"
    }
}

extension User : Identifiable {

}
