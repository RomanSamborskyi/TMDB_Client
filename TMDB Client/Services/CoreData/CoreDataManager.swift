//
//  CoreDataManager.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 18.07.2024.
//

import UIKit
import CoreData


class CoreDataManager {
    
    
    var container: NSPersistentContainer
    private let containerName: String = "MovieContainer"
    private let entityName = "MovieEntity"
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error of load persistenConatainer: \(error)")
            } else {
                print("SUCCESS of load core data")
            }
        }
    }
    
    func addToCoreData(movie: Movie) {
        let newItem = MovieEntity(context: container.viewContext)
        newItem.id = Int32(movie.id ?? 0)
        newItem.title = movie.title
        save()
    }
    
    
    
    func save() {
        do {
           try container.viewContext.save()
        } catch let error {
            print("Error of savig data in to core data: \(error)")
        }
    }
}
