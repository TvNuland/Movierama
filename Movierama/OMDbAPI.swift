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
    
    static func movies(fromJSON data: Data) throws -> [Movie] {
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
        guard let jsonDictionary = jsonObject as? [AnyHashable:Any]
            else {throw MovieError.jsonFormat(details: "jsonDictionary")}
        let finalMovies = try parseResults(searchDict: jsonDictionary as NSDictionary)
        return finalMovies
    }
    
    private static func parseResults(searchDict: NSDictionary) throws -> [Movie] {
        guard let responseMsg = searchDict["Response"] as? String
            else {throw MovieError.jsonFormat(details: "Response keyword not found")}
        if responseMsg == "False" {
            let errorMsg = searchDict["Error"] as? String
            throw MovieError.jsonFormat(details: errorMsg ?? "OMDB response False")
        }
        guard let moviesArray = searchDict["Search"] as? NSArray
            else {throw MovieError.jsonFormat(details: "Search keyword not found")}
        var finalMovies = [Movie]()
        for movieJSON in moviesArray {
            let movie = try parseMovie(fromJSON: movieJSON as! [String : Any])
            finalMovies.append(movie)
        }
        return finalMovies
    }
    
    private static func parseMovie(fromJSON json: [String : Any]) throws -> Movie {
        guard
            let imdbID = json["imdbID"] as? String,
            let title = json["Title"] as? String,
            let year = json["Year"] as? String,
            let poster = json["Poster"] as? String
            else {throw MovieError.jsonFormat(details: "Movie parameters error")}
        return Movie(title: title, imdbID: imdbID, poster: poster, year: year)
    }
    
    private static func MakeURL(parameters: [String: String]) -> URL {
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
