
//
//  TweetCell.swift
//  twitter
//
//  Created by Elana Tee on 2/16/16.
//  Copyright © 2016 Elana Tee. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timePostedLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileView.layer.cornerRadius = 5
        profileView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func onFavorite(sender: AnyObject) {
        favoriteButton.setImage(UIImage(named: "like-action-on-pressed-red"), forState: UIControlState.Normal)        
    
    }

}
