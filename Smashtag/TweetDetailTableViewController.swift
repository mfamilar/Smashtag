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
    
    private let sections = ["Images", "Hashtags", "Users", "URLs"]
    
    private var details = [[String]]()
    
    var tweet: Twitter.Tweet? {
        didSet {
            if let tweet = self.tweet {
                let data = getData(tweet: tweet)
                
                details.append([])
                details.append(data.0)
                details.append(data.1)
                details.append(data.2)
            }
        }
    }
    
    private struct Storyboard {
        static let Detail = "Detail"
    }
    
    private func getData(tweet: Twitter.Tweet) -> ([String], [String], [String]) {
        var mentions = [String]()
        var hashtags = [String]()
        var urls = [String]()
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.Detail, for: indexPath)

        let detail = self.details[indexPath.section][indexPath.row]
        if let tweetDetail = cell as? TweetDetailTableViewCell {
            tweetDetail.detail = detail
        }

        return cell
    }

    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
