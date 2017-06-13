//
//  MovieCD+CoreDataProperties.swift
//  Movierama
//
//  Created by Ton on 2017-06-12.
//  Copyright © 2017 Ton van Nuland. All rights reserved.
//

import Foundation
import CoreData


extension MovieCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieCD> {
        return NSFetchRequest<MovieCD>(entityName: "MovieCD")
    }

    @NSManaged public var imdbID: String?
    @NSManaged public var poster: String?
    @NSManaged public var posterimage: NSObject?
    @NSManaged public var title: String?
    @NSManaged public var year: String?

}
