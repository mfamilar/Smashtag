//
//  TweetTableViewController.swift
//  Smashtag
//
//  Created by Marc FAMILARI on 2/1/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewController: UITableViewController, UITextFieldDelegate, UITabBarControllerDelegate {
    
    var recents: [String] {
        get {
            return UserDefaults.standard.object(forKey: "recents") as? [String] ?? []
        }
        set {
            var mostRecents = newValue
            if newValue.count > 10 {
                mostRecents.removeFirst()
            }
            UserDefaults.standard.set(mostRecents, forKey: "recents")
        }
    }

    var tweets = [Array<Twitter.Tweet>]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var searchText: String? {
        didSet {
            if searchText != nil {
                recents.append(searchText!)
            }
            tweets.removeAll()
            searchForTweets()
            title = searchText
        }
    }
    
    private var twitterRequest: TwitterRequest? {
        if let query = searchText, !query.isEmpty {
            return TwitterRequest(search: query + " -filter:retweets", count: 100)
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
                            weakSelf?.tweets.insert(newTweets, at: 0)
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
        self.tabBarController?.delegate = self
        //        self.navigationItem.hidesBackButton = true
    }

    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tweets.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets[section].count
    }

    private struct Storyboard {
        static let TweetCellIdentifier = "Tweet"
        static let ShowTweetSegue = "Show Details"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.TweetCellIdentifier, for: indexPath)

        let tweet = tweets[indexPath.section][indexPath.row]
        if let tweetCell = cell as? TweetTableViewCell {
            tweetCell.tweet = tweet
        }

        return cell
    }
    
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.delegate = self
            searchTextField.text = searchText
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchText = textField.text
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationvc = segue.destination.contentViewController

        if let tdtvc = destinationvc as? TweetDetailTableViewController {
            if segue.identifier == Storyboard.ShowTweetSegue {
                if (sender as? UITableViewCell) != nil {
                    let indexPath = self.tableView.indexPathForSelectedRow! as NSIndexPath
                    tdtvc.tweet = tweets[indexPath.section][indexPath.row]
                }
            }
        }
    }
   
     func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == 0 {
            searchText = nil
            searchTextField.text = ""
            
        }
    }
}

extension UIViewController {
    var contentViewController: UIViewController {
        get {
            if let navcon = self as? UINavigationController {
                return navcon.visibleViewController ?? self
            } else {
                return self
            }
        }
    }
}
