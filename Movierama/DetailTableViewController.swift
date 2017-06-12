//
//  DetailTableViewController.swift
//  Movierama
//
//  Created by Ton on 2017-05-30.
//  Copyright © 2017 Ton van Nuland. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    var currentMovie: Movie?
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "DetailTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "DetailTableViewCell")
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 350
    }
    
    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
        cell.setDataForTableCell(currentMovie: currentMovie!)
        return cell
    }
}
