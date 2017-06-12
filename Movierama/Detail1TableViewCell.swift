//
//  Detail1TableViewCell.swift
//  Movierama
//
//  Created by Ton on 2017-05-29.
//  Copyright © 2017 Ton van Nuland. All rights reserved.
//

import UIKit

class Detail1TableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setDataForTableCell(currentMovie: Movie) {
        movieImage.image = currentMovie.posterImage
    }
}
