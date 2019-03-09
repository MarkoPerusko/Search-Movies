//
//  MyDataCell.swift
//  searchMovies
//
//  Created by Mac on 2/21/19.
//  Copyright © 2019 crossover. All rights reserved.
//

import UIKit

class MyDataCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieReleaseYear: UILabel!
    @IBOutlet weak var movieType: UILabel!
    
    
}
