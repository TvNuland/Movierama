//
//  Detail2TableViewCell.swift
//  Movierama
//
//  Created by Ton on 2017-06-12.
//  Copyright © 2017 Ton van Nuland. All rights reserved.
//

import UIKit

class Detail2TableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    func setDataForTableCell(currentMovie: Movie) {
        movieTitle.text = currentMovie.title
    }
    
}
