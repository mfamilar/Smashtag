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
    
    private func highlightTweetTextLabel(textLabel: NSMutableAttributedString, textToHighlight: Tweet.IndexedKeyword) {
        let color = highlight[textToHighlight.keyword.characters.first!] ?? UIColor.black
        
        textLabel.addAttribute(NSForegroundColorAttributeName, value:color, range:textToHighlight.nsrange)
        tweetTextLabel.attributedText = textLabel
    }
    
    private var highlight: Dictionary<Character, UIColor> = [
        "@" :   UIColor.orange, // Mention
        "#" :   UIColor.blue, // Hashtag
        "h" :   UIColor.brown // URL
    ]
    
    private func updateUI() {
        
        tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        tweetProfileImageView?.image = nil
        tweetCreatedLabel?.text = nil
        
        if let tweet = self.tweet {
            tweetTextLabel?.text = tweet.text
            if tweetTextLabel?.text != nil {
                var highlightText =  NSMutableAttributedString(string:tweetTextLabel.text!)
                
                for _ in tweet.media {
                    tweetTextLabel.text! += " 📷"
                }
                for mention in tweet.userMentions {
                    highlightTweetTextLabel(textLabel: highlightText, textToHighlight: mention)
                }
                for hashtag in tweet.hashtags {
                    highlightTweetTextLabel(textLabel: highlightText, textToHighlight: hashtag)
                }
                for url in tweet.urls {
                    highlightTweetTextLabel(textLabel: highlightText, textToHighlight: url)
                }
            }
        }
    

        var tweetUserName: String {
            return tweet?.user.name ?? ""
        }
        
        tweetScreenNameLabel?.text = "\(tweetUserName)" //tweet user description
        
        
        if let profileImageURL = tweet?.user.profileImageURL {
            let lastprofileImageURL = profileImageURL
            DispatchQueue.global(qos: .userInteractive).async {
                DispatchQueue.main.async { [weak weakSelf = self] in
                    if profileImageURL == lastprofileImageURL {   
                        if let imageData = NSData(contentsOf: profileImageURL as URL) {
                            weakSelf?.tweetProfileImageView?.image = UIImage(data: imageData as Data)
                        }
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
