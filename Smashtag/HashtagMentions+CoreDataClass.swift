//
//  HashtagMentions+CoreDataClass.swift
//  Smashtag
//
//  Created by Marc FAMILARI on 3/2/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData
import Twitter

@objc(HashtagMentions)
public class HashtagMentions: NSManagedObject {
    class func hashtagMentionsWithTwitterInfo(twitterInfo: Twitter.Tweet, inManagedObjectContext context: NSManagedObjectContext) -> HashtagMentions? {
        print("        USER = \(twitterInfo.user.name)")
        for hashtag in twitterInfo.hashtags {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HashtagMentions")
            request.predicate = NSPredicate(format: "text = %@", hashtag.keyword)
            if let hashtagMention = (try? context.fetch(request))?.first as? HashtagMentions {
                hashtagMention.count += 1
                print("        COUNT = \( hashtagMention.count)          ")
                return hashtagMention }
            if let hashtagMention = NSEntityDescription.insertNewObject(forEntityName: "HashtagMentions", into: context) as? HashtagMentions {
                hashtagMention.text = hashtag.keyword
                hashtagMention.count = 1
                print("        HASH = \( hashtag.keyword)")
                return hashtagMention
            }
        }
        return nil
    }
}
