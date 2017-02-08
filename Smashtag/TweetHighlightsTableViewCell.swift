//
//  TweetDetailsTableViewCell.swift
//  Smashtag
//
//  Created by Marc FAMILARI on 2/3/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//

import UIKit
import Twitter

class TweetHighlightsTableViewCell: UITableViewCell {

    var detail: String? {
        didSet {
            self.textLabel?.text = nil
            self.textLabel?.text = self.detail
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
