
//
//  RecentsTableViewController.swift
//  Smashtag
//
//  Created by Marc FAMILARI on 2/13/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//

import UIKit

class RecentsTableViewController: UITableViewController, UITabBarControllerDelegate {
    
    private var userHistory = [String]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private var ttvc = TweetTableViewController()
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == Storyboard.RecentsTabBarIdentifier {
            if let destinationvc = viewController as? UINavigationController {
                destinationvc.popToRootViewController(animated: true)
                if let rootvc = destinationvc.viewControllers.first as? RecentsTableViewController {
                    rootvc.userHistory = ttvc.recentSearches
                }
            }
        } else {
            if let destinationvc = viewController as? UINavigationController {
                destinationvc.popToRootViewController(animated: true)
                if let rootvc = destinationvc.viewControllers.first as? TweetTableViewController {
                    rootvc.searchText = nil
                    rootvc.searchTextField.text = ""
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userHistory = ttvc.recentSearches
        title = Storyboard.HistoryCellIdentifier
        self.tabBarController?.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userHistory.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.HistoryCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = userHistory[indexPath.row]
        
        return cell
    }
    
    private struct Storyboard {
        static let MostRecentsTweetsCellIdentifier = "Most Recents Tweets"
        static let HistoryCellIdentifier = "History"
        static let RecentsTabBarIdentifier = 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationvc = segue.destination.contentViewController
        
        if let mrttvc = destinationvc as? MostRecentsTweetsTableViewController,
            segue.identifier == Storyboard.MostRecentsTweetsCellIdentifier,
            let cell = sender as? UITableViewCell {
            mrttvc.searchText = cell.textLabel?.text
        }
    }
    
}
