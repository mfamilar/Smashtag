//
//  MostRecentsTweetsTableViewController.swift
//  Smashtag
//
//  Created by Marc FAMILARI on 2/15/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//


import UIKit
import Twitter

class MostRecentsTweetsTableViewController: UITableViewController {

    var tweets = [Tweet]() {
        didSet {
            tableView.reloadData()
        }
    }

    var searchText: String? {
        didSet {
            tweets.removeAll()
            searchForTweets()
            title = searchText
        }
    }
    
    private var twitterRequest: TwitterRequest? {
        if let query = searchText, !query.isEmpty {
            return TwitterRequest(search: query + " -filter:retweets", count: 15)
        }
        return nil
    }
    
    private var lastTwitterRequest: TwitterRequest?
    
    private func searchForTweets() {
        if let request = twitterRequest {
            lastTwitterRequest = request
            request.fetchTweets { [weak weakSelf = self] newTweets in
                DispatchQueue.main.async {
                    if request === weakSelf?.lastTwitterRequest {
                        if !newTweets.isEmpty {
                            for tweet in newTweets  {
                                weakSelf?.tweets.append(tweet)
                            }
                        }
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }

    private struct Storyboard {
        static let TweetsCellIdentifier = "Tweets"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.TweetsCellIdentifier, for: indexPath)
        let tweet = tweets[indexPath.row]
        
        cell.textLabel?.text = tweet.text
        cell.detailTextLabel?.text = tweet.user.name
        
        return cell
    }
}
