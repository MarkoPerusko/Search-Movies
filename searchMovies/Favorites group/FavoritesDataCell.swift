//
//  FavoritesDataCell.swift
//  searchMovies
//
//  Created by Mac on 3/1/19.
//  Copyright © 2019 crossover. All rights reserved.
//

import UIKit

class FavoritesDataCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var releaseYear: UILabel!
    @IBOutlet weak var genre: UILabel!
    
}
