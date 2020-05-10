//
//  DiscoverTableViewCell.swift
//  ProjectMovie
//
//  Created by Jerry Purnama Maulid on 10/05/20.
//  Copyright © 2020 Jerry Purnama Maulid. All rights reserved.
//

import UIKit
import SDWebImage

class DiscoverTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTItle: UILabel!
    @IBOutlet weak var rateMovie: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var descrip: UILabel!
    
    var data: DiscoverResults? {
        didSet {
            if let  value = self.data {
                let urlString = Config.URL.basePoster+(value.posterPath ?? "")
                Helper.loadImage(imageView: self.movieImage, url: urlString)
                movieTItle.text = value.title
                rateMovie.text = "\(value.voteAverage ?? 0)"
                releaseDate.text = value.releaseDate
                descrip.text  = value.overview
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
