//
//  CoreDataManager.swift
//  Movierama
//
//  Created by Ton on 2017-06-12.
//  Copyright © 2017 Ton van Nuland. All rights reserved.
//

import CoreData

class CoredataManager {
    
    static let sharedInstance = CoredataManager()
    
    private init() { }
    
    lazy var persistentContainer: NSPersistentContainer = {
        /* The  persistent container  for  the application .   This
         creates  and  returns a container ,  having loaded the
         application to it .   This  property  is  optional since
         error conditions that could cause the creation of the store to fail.  */
        let container = NSPersistentContainer (name: "Movierama")
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                /* Typical  reasons  for  an error here include:
                 *   The  parent directory does  not  exist ,  cannot be created ,   or
                 disallows writing.
                 *   The  persistent store  is   not  accessible ,  due to permissions  or
                 data protection  when  the device  is  locked.
                 *   The  device  is   out  of space.
                 was.
                 }
                 *   The  store could  not  be migrated to the current model version.  Check  the error message to determine what the actual problem
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch  {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                let nserror = error as NSError
                fatalError ( "Unresolved error \(nserror), \(nserror.userInfo)") }
        }
    }
    
    func fillContext(movie: Movie) {
        let context = CoredataManager.sharedInstance.persistentContainer.viewContext
        context.performAndWait {
            let movieManagedObject = MovieCD(context: context)
            movieManagedObject.title = movie.title
            movieManagedObject.poster = movie.poster
            movieManagedObject.posterimage = movie.posterImage
            movieManagedObject.imdbID = movie.imdbID
            movieManagedObject.year = movie.year
        }
    }
}