//
//  AppDelegate.swift
//  CoreDataMigrationPractice
//
//  Created by 정성훈 on 2022/01/13.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        // v1 mock data
//        if UserDefaults.standard.bool(forKey: "mock") == false {
//            print("목데이터 생성")
//
//            let names = ["김철수", "박영희", "이상우", "노진구", "이비실", "김호랑"]
//            let sex = ["man", "woman"]
//
//            for _ in 0..<10 {
//                let user = User(context: persistentContainer.viewContext)
//                user.name = names[Int.random(in: 0..<names.count)]
//                user.sex = sex[Int.random(in: 0..<sex.count)]
//                saveContext()
//            }
//            UserDefaults.standard.setValue(true, forKey: "mock")
//        }
        
        // v2 mock data
//        if UserDefaults.standard.bool(forKey: "mock") == false {
//            print("목데이터 생성")
//
//            let names = ["김철수", "박영희", "이상우", "노진구", "이비실", "김호랑"]
//            let fetchRequest = Gender.fetchRequest()
//            let results = try? persistentContainer.viewContext.fetch(fetchRequest)
//            for _ in 0..<10 {
//                let user = User(context: persistentContainer.viewContext)
//                user.name = names[Int.random(in: 0..<names.count)]
//                if let results = results {
//                    user.gender = results.count != 0 ? results[Int.random(in: 0..<results.count)] : nil
//                }
//                saveContext()
//            }
//            UserDefaults.standard.setValue(true, forKey: "mock")
//        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CoreDataMigrationPractice")
        
        let persistentStoreDescription = container.persistentStoreDescriptions.first
        persistentStoreDescription?.setOption(true as NSNumber, forKey: NSMigratePersistentStoresAutomaticallyOption)
        persistentStoreDescription?.setOption(false as NSNumber, forKey: NSInferMappingModelAutomaticallyOption)
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

