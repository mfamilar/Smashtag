//
//  TweetDetailsTableViewCell.swift
//  Smashtag
//
//  Created by Marc FAMILARI on 2/3/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//

import UIKit
import Twitter

class TweetDetailTableViewCell: UITableViewCell {

    var detail: AnyObject? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        self.textLabel?.text = nil
        self.imageView?.image = nil
        
        switch detail {
        case is UIImage:
            self.imageView?.image = self.detail as! UIImage!
        case is String:
            self.textLabel?.text = self.detail as! String?
        default:
            break
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
