//
//  BusinessCell.swift
//  Yelp
//
//  Created by Singh, Uttam on 4/7/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
    @IBOutlet weak var thumbnilImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var reviewsCountLabel: UILabel!
    @IBOutlet weak var addresslabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var business : Business! {
        didSet{
            nameLabel.text = business.name
            thumbnilImageView.setImageWith(business.imageURL!)
            addresslabel.text = business.address
            categoryLabel.text = business.categories
            reviewsCountLabel.text = "\(business.reviewCount!) Reviews"
            ratingImageView.setImageWith(business.ratingImageURL!)
            distanceLabel.text = business.distance
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        thumbnilImageView.layer.cornerRadius = 3
        thumbnilImageView.clipsToBounds = true
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
       
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
       
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
