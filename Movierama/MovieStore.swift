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
    
    private func processMoviesRequest(data: Data?) throws -> [Movie]  {
        guard let jsonData = data
            else {throw MovieError.jsonData(details: data?.description ?? "No Data")}
        return try OMDbAPI.movies(fromJSON: jsonData)
    }

    func searchRequestedMovie(forMovie: String, completion: @escaping (_ inner: () throws -> [Movie]) -> Void) -> Void {
        let url = OMDbAPI.makeSearchURL(forMovie: forMovie)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            do {
                let movies = try self.processMoviesRequest(data: data)
                OperationQueue.main.addOperation {
                    completion({return movies})
                }
            } catch {completion({throw MovieError.jsonData(details: "movieTask")})
            }
        }
        task.resume()
    }
    
//    func searchRequestedMovie(forMovie: String, completion: @escaping ([Movie]) -> Void) throws {
//        let url = OMDbAPI.makeSearchURL(forMovie: forMovie)
//        let request = URLRequest(url: url)
//        let task = try session.dataTask(with: request) {
//            (data, response, error) -> Void in
//            let movies = try self.processMoviesRequest(data: data)
//            OperationQueue.main.addOperation {
//                completion(movies)
//            }
//        }
//        task.resume()
//    }

    private func processImageRequest(data: Data?) -> UIImage {
        if let posterData = data,
            let image = UIImage(data: posterData) {
            return image
        }
        else {
            return #imageLiteral(resourceName: "No Poster")
        }
    }
    
    func loadRequestedImage(forPoster: String, completion: @escaping (UIImage) -> Void) {
        if let url = URL(string: forPoster) {
            let request = URLRequest(url: url)
            let task = session.dataTask(with: request) {
                (data, response, error) -> Void in
                let image: UIImage = self.processImageRequest(data: data)
                OperationQueue.main.addOperation {
                    completion(image)
                }
            }
            task.resume()
        } else {
            completion(#imageLiteral(resourceName: "No Poster"))
        }
    }
}
