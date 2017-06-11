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
    var currentSearchText: String = ""
    
    //    var detailMovie: DetailMovie?
    
    var store: MovieStore!
    var movies: [Movie] = []
    //    {
    //        didSet {
    //            self.tableView.reloadData()
    //        }
    //    }
    
    func searchMovies(forMovie: String) {
        store.searchRequestedMovie(forMovie: forMovie) {
            (inner: () throws -> [Movie]) -> Void in
            do {
                self.movies = try inner()
                self.iterateMoviesFound(moviesFound: self.movies)
            } catch MovieError.jsonData(let details) {
                print("Error in jsonData \(details)")
            } catch MovieError.jsonSerialization(let details) {
                print("Error in jsonSerialization \(details)")
            } catch MovieError.jsonFormat(let details) {
                print("Error in jsonFormat \(details)")
            } catch MovieError.omdbRequest(let details) {
                print("Error in omdbRequest \(details)")
            } catch {
                print("Unknown Error")
            }
        }
    }
    
    func iterateMoviesFound(moviesFound: [Movie]) {
        for movie in moviesFound {
            if movie.poster != "N/A" {
                loadImage(forMovie: movie)
            } else {
                movie.posterImage = #imageLiteral(resourceName: "No Poster")
                self.tableView.reloadData()
            }
            self.movies.append(movie)
        }
    }
    
    func loadImage(forMovie: Movie) {
        store.loadRequestedImage(forPoster: forMovie.poster) {
            (image) -> Void in
            forMovie.posterImage = image
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "MovieTableViewCell")
        
        searchController.accessibilityLabel = "search"
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.delegate = self
        
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
        //        print(currentMovie.title, currentMovie.imdbID, currentMovie.poster, currentMovie.posterImage ?? nil)
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
