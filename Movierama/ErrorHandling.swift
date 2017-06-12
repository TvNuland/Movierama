//
//  ErrorHandling.swift
//  Movierama
//
//  Created by Ton on 2017-06-09.
//  Copyright © 2017 Ton van Nuland. All rights reserved.
//

import Foundation

enum MovieError: Error {
    case jsonData(details: String)
    case jsonSerialization(details: String)
    case jsonFormat(details: String)
    case omdbRequest(details: String)
}

