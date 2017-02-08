//
//  TweetDetailsTableViewController.swift
//  Smashtag
//
//  Created by Marc FAMILARI on 2/3/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//

import UIKit
import Twitter

class TweetDetailTableViewController: UITableViewController {
    
    private var sections: [String] = []
    
    private var details = [[AnyObject]]()
    
    private var tweetImage: MediaItem?

    var tweet: Twitter.Tweet? {
        didSet {
            getData()
            title = tweet?.user.name
        }
    }
    
    private struct Storyboard {
        static let Details = "Details"
    }
    
    private func fetchImage() {
        if let url = tweetImage?.url {
            DispatchQueue.global(qos: .userInteractive).async {
                let contentsOfURL = NSData(contentsOf: url as URL)
                DispatchQueue.main.async { [weak weakSelf = self] in
                    if url == weakSelf?.tweetImage?.url {
                        if let imageData = contentsOfURL {
                            if let image = UIImage(data: imageData as Data) {
                                weakSelf?.details[0].append(image as AnyObject)
                                weakSelf?.tableView.reloadData()
                            }
                        }
                    } else {
                        print("ignored data returned from url \(url)")
                    }
                }
            }
        }
    }
    
    private func createTableViewSections(tweet: [Twitter.Tweet.IndexedKeyword], section: String) {
        var array = [AnyObject]()
        
        for element in tweet {
                array.append(element.keyword as AnyObject)
        }
        if !array.isEmpty {
            sections.append(section)
             details.append(array)
        }
    }
    
    private func getData() {
        if let tweet = self.tweet {
            for image in tweet.media {
                tweetImage = image
                sections.append("Images")
                details.append([])
                fetchImage()
            }
            createTableViewSections(tweet: tweet.hashtags, section: "Hashtags")
            createTableViewSections(tweet: tweet.userMentions, section: "Users")
            createTableViewSections(tweet: tweet.urls, section: "URLs")
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if let ratio = tweetImage?.aspectRatio {
                return CGFloat(ratio) * tableView.bounds.size.width
            }
        }
        return UITableViewAutomaticDimension
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.Details, for: indexPath)
        
        let details = self.details[indexPath.section][indexPath.row]
        
        if let tweetDetail = cell as? TweetDetailTableViewCell {
            tweetDetail.detail = details
        }
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
