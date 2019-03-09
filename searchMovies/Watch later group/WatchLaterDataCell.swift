//
//  WatchLaterDataCell.swift
//  searchMovies
//
//  Created by Mac on 3/2/19.
//  Copyright © 2019 crossover. All rights reserved.
//

import UIKit

class WatchLaterDataCell: UITableViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var releaseYear: UILabel!
    @IBOutlet weak var genre: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
