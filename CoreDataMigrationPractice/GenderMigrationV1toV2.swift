//
//  GenderMigrationV1toV2.swift
//  CoreDataMigrationPractice
//
//  Created by 정성훈 on 2022/01/18.
//

import CoreData

class GenderMigrationV1toV2: NSEntityMigrationPolicy {
    override func createDestinationInstances(forSource sInstance: NSManagedObject, in mapping: NSEntityMapping, manager: NSMigrationManager) throws {
        
        try super.createDestinationInstances(forSource: sInstance, in: mapping, manager: manager)

        var genderInstance: NSManagedObject!

        let sexName = sInstance.value(forKey: "sex") as! String
        let genderType = sexName == "man" ? "male" : "female"
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Gender")
        fetchRequest.predicate = NSPredicate(format: "type = %@", genderType)
        let results = try manager.destinationContext.fetch(fetchRequest)

        if let resultInstance = results.last as? NSManagedObject {
            genderInstance = resultInstance
        } else {
            let entity = NSEntityDescription.entity(forEntityName: "Gender", in: manager.destinationContext)!
            genderInstance = NSManagedObject(entity: entity, insertInto: manager.destinationContext)
            genderInstance.setValue(genderType, forKey: "type")
        }

        let destResults = manager.destinationInstances(forEntityMappingName: mapping.name, sourceInstances: [sInstance])
        if let destinationUser = destResults.last {
            destinationUser.setValue(genderInstance, forKey: "gender")
        }
    }
}

