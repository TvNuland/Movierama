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
        
        let nib1 = UINib(nibName: "Detail1TableViewCell", bundle: nil)
        self.tableView.register(nib1, forCellReuseIdentifier: "Detail1TableViewCell")
        let nib2 = UINib(nibName: "Detail2TableViewCell", bundle: nil)
        self.tableView.register(nib2, forCellReuseIdentifier: "Detail2TableViewCell")
        
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
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell1: Detail1TableViewCell = tableView.dequeueReusableCell(withIdentifier: "Detail1TableViewCell", for: indexPath) as! Detail1TableViewCell
            cell1.setDataForTableCell(currentMovie: currentMovie!)
            return cell1
        case 1:
            let cell2: Detail2TableViewCell = tableView.dequeueReusableCell(withIdentifier: "Detail2TableViewCell", for: indexPath) as! Detail2TableViewCell
            cell2.setDataForTableCell(currentMovie: currentMovie!)
            return cell2
        default:
            print("DetailTableViewController cellForRowAt")
            let cell9 = UITableViewCell()
            return cell9
        }
    }
}
