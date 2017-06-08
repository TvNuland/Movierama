//
//  MovieStore.swift
//  Movierama
//
//  Created by Ton on 2017-06-06.
//  Copyright © 2017 Ton van Nuland. All rights reserved.
//

import UIKit

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
            OperationQueue.main.addOperation {
                completion(result)
           }
        }
        task.resume()
    }
    
    private func processImageRequest(data: Data?, error: Error?) -> UIImage? {
        guard let posterData = data,
            let image = UIImage(data: posterData) else {
                print("Error processImageRequest")
                return nil
        }
        return image
    }
    
    func loadRequestedImage(forPoster: String, completion: @escaping (UIImage) -> Void) {
        let url = URL(string: forPoster)
        let request = URLRequest(url: url!)
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            let result = self.processImageRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result!)
            }
        }
        task.resume()
    }
}
