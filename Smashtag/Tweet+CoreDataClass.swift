//
//  Tweet+CoreDataClass.swift
//  Smashtag
//
//  Created by Marc FAMILARI on 3/2/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData
import Twitter

@objc(Tweet)
public class Tweet: NSManagedObject {
    class func tweetWithTwitterInfo(twitterInfo: Twitter.Tweet, inManagedObjectContext context: NSManagedObjectContext) -> Tweet? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Tweet")
        if let id = twitterInfo.id {
            request.predicate = NSPredicate(format: "unique = %@", id)
        }
        if let tweet = (try? context.fetch(request))?.first as? Tweet {
            return tweet
        } else if let tweet = NSEntityDescription.insertNewObject(forEntityName: "Tweet", into: context) as? Tweet  {
            tweet.text = twitterInfo.text
            tweet.unique = twitterInfo.id
            tweet.posted = twitterInfo.created
            tweet.tweeter = TwitterUser.twitterUserWithTwitterInfo(twitterInfo: twitterInfo.user, inManagedObjectContext: context)
            tweet.mentions = HashtagMentions.hashtagMentionsWithTwitterInfo(twitterInfo: twitterInfo, inManagedObjectContext: context)
            return tweet
        }
        return nil
    }
}
