//
//  MovieStore.swift
//  Movierama
//
//  Created by Ton on 2017-06-06.
//  Copyright © 2017 Ton van Nuland. All rights reserved.
//

import Foundation

class MovieStore {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    private func processMoviesRequest(data: Data?, error: Error?) -> [Movie] {
        guard let jsonData = data else {
            print("Error processMoviesRequest")
            return []
        }
        
        return OMDbAPI.movies(fromJSON: jsonData)
    }
    
    func searchRequestedMovies(forMovie: String, completion: @escaping ([Movie]) -> Void) {
        
        let url = OMDbAPI.makeSearchURL(forMovie: forMovie)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            let result = self.processMoviesRequest(data: data, error: error)
            completion(result)
            
        }
        task.resume()
    }
    
}
