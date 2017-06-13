//
//  CoreDataService.swift
//  Movierama
//
//  Created by Ton on 2017-06-13.
//  Copyright © 2017 Ton van Nuland. All rights reserved.
//

import Foundation
import CoreData

typealias fetchMoviesResponse = ([MovieCD]?, Bool, NSError?) -> Void

class CoreDataService {
    
    static func fetchFavouritedMovies(onCompletion: @escaping fetchMoviesResponse) {
        let fetchRequest: NSFetchRequest<MovieCD> = MovieCD.fetchRequest()
        
        let sortByMovieTitle = NSSortDescriptor(key: #keyPath(MovieCD.title), ascending: true)
        fetchRequest.sortDescriptors = [sortByMovieTitle]
        
        let viewContext = CoredataManager.sharedInstance.persistentContainer.viewContext
        
        viewContext.perform {
            do {
                let allMovies = try viewContext.fetch(fetchRequest)
                onCompletion(allMovies, true, nil)
            } catch let error{
                onCompletion(nil, false, error as NSError)
            }
        }
    }
}
