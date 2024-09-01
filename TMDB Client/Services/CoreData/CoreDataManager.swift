//
//  CoreDataManager.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 01.09.2024.
//

import UIKit
import CoreData


class CoreDataManager {
    
    static let instance = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    private var containerName: String = "User"
    private var entityName: String = "UserEntity"
    
    private init() {
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
    
    private func save() {
        do {
            try context.save()
        } catch {
            print("Error of saving coreData")
        }
    }
    func writeToCoreData(user: UserProfile, _ avatar: Data) throws {
        let newUser = UserEntity(context: context)
        newUser.id = Int32(user.id ?? 0)
        newUser.name = user.name
        newUser.userName = user.username
        newUser.includeAdult = user.includeAdult ?? false
        newUser.iso3166_1 = user.iso3166_1
        newUser.iso639_1 = user.iso639_1
        newUser.avatar = avatar
        save()
    }
    func fetchUserDetails() throws -> UserProfile? {
        let request = NSFetchRequest<UserEntity>(entityName: entityName)
        do {
            guard let user = try context.fetch(request).first else { return nil }
            return UserProfile(avatar: nil, id: Int(user.id), iso639_1: user.iso639_1, iso3166_1: user.iso3166_1, name: user.name, includeAdult: user.includeAdult, username: user.userName, uiImageAvatar: user.avatar)
        } catch let error {
            print("error of fetching user :\(error)")
            throw error
        }
    }
    func deleteUserData() throws {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let batchRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try self.context.execute(batchRequest)
            save()
        } catch let error {
            print("error of deleting user: \(error)")
        }
    }
}
