//
//  TableViewControllerSearch.swift
//  Movierama
//
//  Created by Ton on 2017-06-08.
//  Copyright © 2017 Ton van Nuland. All rights reserved.
//

import UIKit

extension TableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    
    // MARK: UISearchResultsUpdating
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {
        
        //Filter content for search
        if searchController.isActive && isMoreThanTwoCharacter(searchController) && hasSearchTextChanged(searchController) {
 //           movies = []
            self.currentSearchText = searchController.searchBar.text!
            self.scheduledSearch(searchBar: searchController.searchBar, page: 1)
        }
    }
    
    
    func isMoreThanTwoCharacter(_ searchController: UISearchController) -> Bool {
        return (searchController.searchBar.text?.characters.count)! > 2
    }
    
    func hasSearchTextChanged(_ searchController: UISearchController) -> Bool{
        return self.currentSearchText != searchController.searchBar.text
    }
    
    func scheduledSearch(searchBar: UISearchBar, page: Int) {
        let SEARCH_DELAY_IN_MS: Int = 1 // change to desired number of seconds
        let popTime = DispatchTime.now() + .seconds(SEARCH_DELAY_IN_MS)
        
        //the value of text is retained in the thread we spawn off main queue
        let text = searchBar.text ?? ""
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            if text == searchBar.text {
                //CALL THE OMDB SEARCH FUNCTION HERE
                self.searchMovies(forMovie: text)
            }
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchController.isActive && (searchBar.text?.characters.count)! >= 2 && self.currentSearchText != searchBar.text {
            let text = searchBar.text ?? ""
            if text == searchBar.text {
                self.currentSearchText = text
                searchMovies(forMovie: text)
            }
        }
    }
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.returnKeyType = UIReturnKeyType.done // because of the update search results automatically being fired keyboard must say done not search
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
 //       self.tableView.reloadData()
        movies = []
        self.tableView.reloadData()
    }
    
    
}
