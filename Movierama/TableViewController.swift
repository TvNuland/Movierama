//
//  TableViewController.swift
//  Movierama
//
//  Created by Ton on 2017-06-07.
//  Copyright © 2017 Ton van Nuland. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var store: MovieStore!
    var movies: [Movie] = []
//    {
//        didSet {
//            self.tableView.reloadData()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "MovieTableViewCell")
        
        
        store.searchRequestedMovies(forMovie: "Jaws") {
            (moviesFound) -> Void in
            for movie in moviesFound {
                if movie.poster != "N/A" {
                    self.store.loadRequestedImage(forPoster: movie.poster) {
                        (image) -> Void in
                        movie.posterImage = image
                        self.tableView.reloadData()
                    }
                }
                self.movies.append(movie)
 //               self.tableView.reloadData()
                //                print(movie.title, movie.imdbID, movie.poster, movie.posterImage?.size)
            }
//            for movie in self.movies {
//                print(movie.title, movie.imdbID, movie.poster, movie.posterImage ?? nil)
//            }
        }
        
        
        //        for movie in movies {
        //            store.loadRequestedImage(forPoster: movie.poster) {
        //                (image) -> Void in
        //                movie.posterImage = image
        //            }
        //        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        let currentMovie = movies[indexPath.row]
        cell.setDataForTableCell(movie: currentMovie)
        print(currentMovie.title, currentMovie.imdbID, currentMovie.poster, currentMovie.posterImage ?? nil)
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
