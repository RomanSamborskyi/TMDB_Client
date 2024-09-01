//
//  CoreDataManager.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 01.09.2024.
//

import UIKit
import CoreData


class CoreDataManager {
    
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    private var containerName: String = "User"
    private var entityName: String = "UserEntity"
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { description, error in
            if error == nil {
                print("Success of load CoreData ✅")
            } else {
                print("Error of load CoreData ❌")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print("Error of saving coreData")
        }
    }
}
