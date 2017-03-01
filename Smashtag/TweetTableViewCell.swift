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
    
    private func highlightTweetTextLabel(textLabel: NSMutableAttributedString, textToHighlight: [Twitter.Tweet.IndexedKeyword]) {
        for highlight in textToHighlight {
            let color = colors[highlight.keyword.characters.first!] ?? UIColor.black
            textLabel.addAttribute(NSForegroundColorAttributeName, value:color, range:highlight.nsrange)
            tweetTextLabel?.attributedText = textLabel
            
        }
    }
    
    private var colors: Dictionary<Character, UIColor> = [
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
            if let textLabel = tweetTextLabel?.text {
                var highlightText =  NSMutableAttributedString(string: textLabel)
                
                for _ in tweet.media {
                    highlightText.append(NSMutableAttributedString(string: " 📷"))
                    tweetTextLabel?.attributedText = highlightText
                }
                highlightTweetTextLabel(textLabel: highlightText, textToHighlight: tweet.userMentions)
                highlightTweetTextLabel(textLabel: highlightText, textToHighlight: tweet.hashtags)
                highlightTweetTextLabel(textLabel: highlightText, textToHighlight: tweet.urls)
            }
        }
        
        
        var tweetUserName: String {
            return tweet?.user.description ?? ""
        }
        
        tweetScreenNameLabel?.text = "\(tweetUserName)" //tweet user description
        
        
        if let profileImageURL = tweet?.user.profileImageURL {
            let lastprofileImageURL = profileImageURL
            DispatchQueue.global(qos: .userInteractive).async {
                if let imageData = NSData(contentsOf: profileImageURL as URL) {
                    DispatchQueue.main.async { [weak weakSelf = self] in
                        if profileImageURL == lastprofileImageURL {
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
