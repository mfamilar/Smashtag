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
    
    private struct UserDefaultsSettings {
        static let Key = "Recents"
        static let MaxSizeHistory = 100
    }
    
    var recentsSearch: [String] {
        get {
            return UserDefaults.standard.object(forKey: UserDefaultsSettings.Key) as? [String] ?? []
        }
        set {
            var mostRecents = newValue
            if newValue.count > UserDefaultsSettings.MaxSizeHistory {
                mostRecents.removeFirst()
            }
            UserDefaults.standard.set(mostRecents, forKey: UserDefaultsSettings.Key)
        }
    }

    var tweets = [Array<Twitter.Tweet>]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var searchText: String? {
        didSet {
            if let textToSave = searchText {
                recentsSearch.append(textToSave)
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

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == Storyboard.SearchTabBarIdentifier {
            searchText = nil
            searchTextField.text = ""
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tabBarController?.delegate = self
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
        static let SearchTabBarIdentifier = 0
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
                    if let indexPath = self.tableView.indexPathForSelectedRow {
                        tdtvc.tweet = tweets[indexPath.section][indexPath.row]
                    }
                }
            }
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
