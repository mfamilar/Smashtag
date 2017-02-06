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
    
    private var details = [[String]]()
    
    private var image: UIImage?
    
    private var imageURL: NSURL? {
        didSet {
            fetchImage()
        }
    }
    
    var tweet: Twitter.Tweet? {
        didSet {
            if let tweet = self.tweet {
                let data = getData(tweet: tweet)
                details.append(data.0)
                details.append(data.1)
                details.append(data.2)
            }
        }
    }
    
    private struct Storyboard {
        static let Highlights = "Highlights"
        static let Image = "Image"
    }
    
    private func fetchImage() {
        if let url = imageURL {
            DispatchQueue.global(qos: .userInteractive).async {
                let contentsOfURL = NSData(contentsOf: url as URL)
                DispatchQueue.main.async { [weak weakSelf = self] in
                    if url == weakSelf?.imageURL {
                        if let imageData = contentsOfURL {
                            if let image = UIImage(data: imageData as Data) {
                                weakSelf?.image = image
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
    
    private func getData(tweet: Twitter.Tweet) -> ([String], [String], [String]) {
        var mentions = [String]()
        var hashtags = [String]()
        var urls = [String]()
        
        for image in (tweet.media) {
            imageURL = image.url
        }
        for hashtag in (tweet.hashtags) {
            hashtags.append(hashtag.keyword)
        }
        for mention in (tweet.userMentions) {
            mentions.append(mention.keyword)
        }
        for url in (tweet.urls) {
            urls.append(url.keyword)
        }
        return (hashtags, mentions, urls)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sections = ["Hashtags", "Users", "URLs"]
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
        let highlightsCell = tableView.dequeueReusableCell(withIdentifier: Storyboard.Highlights, for: indexPath)
//        let imageCell = tableView.dequeueReusableCell(withIdentifier: Storyboard.Image, for: indexPath)

        let highlights = self.details[indexPath.section][indexPath.row]
        if let tweetDetail = highlightsCell as? TweetDetailTableViewCell {
            tweetDetail.detail = highlights
        }
        
//        if let image = self.image {
//            if let tweetDetail = imageCell as? TweetDetailTableViewCell {
//                tweetDetail.pic = image
//            }
//        }
        
        return highlightsCell
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
