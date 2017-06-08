//
//  MovieTableViewCell.swift
//  Movierama
//
//  Created by Ton on 2017-06-07.
//  Copyright © 2017 Ton van Nuland. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataForTableCell(movie: Movie) {
        self.movieTitle.text = movie.title
        self.moviePoster.image = movie.posterImage
    }

}
