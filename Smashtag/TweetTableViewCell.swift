//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by Marc FAMILARI on 2/1/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    
    var tweet: Twitter.Tweet? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        
        // reset any existing tweet information
        tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        tweetProfileImageView?.image = nil
        tweetCreatedLabel?.text = nil
        
        // load more information from our tweet (if any)
        if let tweet = self.tweet {
            tweetTextLabel?.text = tweet.text
            if tweetTextLabel?.text != nil {
                for _ in tweet.media {
                    tweetTextLabel.text! += " 📷"
                }
            }
        }
        
        var tweetUserName: String {
            return tweet?.user.name ?? ""
        }
        
        tweetScreenNameLabel?.text = "\(tweetUserName)" //tweet user description
        
        
        if let profileImageURL = tweet?.user.profileImageURL {
            DispatchQueue.global(qos: .userInteractive).async {
                DispatchQueue.main.async { [weak weakSelf = self] in
                    if let imageData = NSData(contentsOf: profileImageURL as URL) {
                        weakSelf?.tweetProfileImageView?.image = UIImage(data: imageData as Data)
                    }
                }
            }
        }
        
        let formatter = DateFormatter()
        if NSDate().timeIntervalSince(tweet?.created as! Date) > 24*60*60 {
            formatter.dateStyle = DateFormatter.Style.short
        } else {
            formatter.timeStyle = DateFormatter.Style.short
        }
        tweetCreatedLabel?.text = formatter.string(from: tweet?.created as! Date)
    }

}
