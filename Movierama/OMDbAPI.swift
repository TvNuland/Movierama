//
//  OMDbAPI.swift
//  Movierama
//
//  Created by Ton on 2017-06-06.
//  Copyright © 2017 Ton van Nuland. All rights reserved.
//

import Foundation

struct OMDbAPI {
    
    private static let schemeKey = "scheme"
    private static let schemeValue = "https"
    private static let hostKey = "host"
    private static let hostValue = "www.omdbapi.com"
    private static let pathKey = "path"
    private static let pathValue = ""
    private static let baseURL = schemeValue + "://" + hostValue + "/"
    private static let apiKey = "apikey"
    private static let apiValue = "3b0c7c0c"
    private static let searchKey = "s"
    private static let imdbIDKey = "i"
    
    static func makeSearchURL(forMovie: String) -> URL {
        return MakeURL(parameters: [searchKey: forMovie])
    }
    
    static func makeIDURL(forIMDbID: String) -> URL {
        return MakeURL(parameters: [imdbIDKey: forIMDbID])
    }
    
    static func movies(fromJSON data: Data) -> [Movie] {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard
                let jsonDictionary = jsonObject as? [AnyHashable:Any],
                let moviesArray = jsonDictionary["Search"] as? NSArray
//                let moviesArray = movies["Title"] as? [[String:Any]]
                else {
                    print("JSON structure error")
                    return []
            }
            
            var finalMovies = [Movie]()
            
            for movieJSON in moviesArray {
                if let movie = movie(fromJSON: movieJSON as! [String : Any]) {
                    finalMovies.append(movie)
                }
            }
            
            if finalMovies.isEmpty && moviesArray != [] {
                print("Error JSON format error")
                return []
            }
            
            return finalMovies
        } catch let error {
            print("Error JSONSerialization: \(error)")
            return []
        }
    }
    
    private static func movie(fromJSON json: [String : Any]) -> Movie? {
        guard
            let imdbID = json["imdbID"] as? String,
            let title = json["Title"] as? String,
            let year = json["Year"] as? String,
            let poster = json["Poster"] as? String
             else {
                return nil
        }
        return Movie(title: title, imdbID: imdbID, poster: poster, year: year)
    }
    
    private static func MakeURL(parameters: [String:String]) -> URL {
        var components = URLComponents(string: baseURL)!
        var queryItems = [URLQueryItem]()
        let baseParms = [schemeKey : schemeValue,
                         hostKey : hostValue,
                         pathKey : pathValue,
                         apiKey : apiValue]
        
        for (key, value) in baseParms {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        for (key, value) in parameters {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        components.queryItems = queryItems
        return components.url!
    }
}
