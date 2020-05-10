//
//  ReviewsTableViewCell.swift
//  ProjectMovie
//
//  Created by Jerry Purnama Maulid on 11/05/20.
//  Copyright © 2020 Jerry Purnama Maulid. All rights reserved.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {
    @IBOutlet weak var userAuthor: UILabel!
    @IBOutlet weak var commentReview: UILabel!
    
    var review: MovieReviewsResults? {
        didSet {
            guard let value = self.review else {
                return
            }
            self.userAuthor.text = "Author: "+(value.author ?? "")
            self.commentReview.text = value.content
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
