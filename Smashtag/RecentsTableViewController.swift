//
//  RecentsTableViewController.swift
//  Smashtag
//
//  Created by Marc FAMILARI on 2/13/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//

import UIKit

class RecentsTableViewController: UITableViewController, UITabBarControllerDelegate {
    
    private var data = [String]()
    
    private var ttvc = TweetTableViewController()
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == 1 {
            data = ttvc.recents
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = ttvc.recents
        self.tabBarController?.delegate = self
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Recents", for: indexPath)
        
        cell.textLabel?.text = data[indexPath.row]

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationvc = segue.destination.contentViewController
        
        if destinationvc is TweetTableViewController {
            if segue.identifier == "Recents Search" {
                print("SENDER = \(sender)")
                 if let cell = sender as? UITableViewCell {
                    print("       RECENT                 =\(cell.textLabel?.text)"              )
                    ttvc.searchText = cell.textLabel!.text
                }
            }
        }
    }

}
