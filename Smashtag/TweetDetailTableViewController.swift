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
    
    private var details = [[AnyObject]]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private var tweetImage: MediaItem?
    
    var tweet: Twitter.Tweet? {
        didSet {
            getData()
            title = tweet?.user.name
        }
    }
    
    private struct Storyboard {
        static let Details = "Details"
        static let NewSearchText = "New Search Text"
        static let ShowImage = "Show Image"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval)
    {
        self.tableView.reloadData()
    }
    
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if let ratio = tweetImage?.aspectRatio {
                return (tableView.bounds.size.width / CGFloat(ratio))
            }
        }
        return UITableViewAutomaticDimension
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
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if let firstChar =  cell?.textLabel?.text?.characters.first {
            if let constant = dataType[firstChar] {
                switch constant {
                case .User, .Hashtag:
                    performSegue(withIdentifier: Storyboard.NewSearchText, sender: cell?.textLabel?.text)
                default:
                    UIApplication.shared.open(URL(string: (cell?.textLabel?.text)!)!, options: [:], completionHandler: nil)
                }
            }
        } else {
            performSegue(withIdentifier: Storyboard.ShowImage, sender: self.details[indexPath.section][indexPath.row])
        }
    }
    
    enum DataType {
        case Image
        case Hashtag
        case User
        case URL
    }
    
    private var dataType: Dictionary<Character, DataType> = [
        "@" :   .User,
        "#" :   .Hashtag,
        "h" :   .URL,
        ]
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationvc = segue.destination.contentViewController
        
        if segue.identifier == Storyboard.NewSearchText {
            if let ttvc = destinationvc as? TweetTableViewController {
                if let newSearchText = sender as? String {
                    ttvc.searchText = newSearchText
                }
            }
        }
        else if segue.identifier == Storyboard.ShowImage {
            if let ivc = destinationvc as? ImageViewController {
                if let image = sender as? UIImage {
                    ivc.image = image
                }
            }
        }
        
    }
    
}
