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
        for hashtag in twitterInfo.hashtags {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HashtagMention")
            request.predicate = NSPredicate(format: "mention = %@", hashtag.keyword)
            if let hashtagMention = (try? context.fetch(request))?.first as? HashtagMentions {
                hashtagMention.count += 1
                return hashtagMention
            } else if let hashtagMention = NSEntityDescription.insertNewObject(forEntityName: "HashtagMention", into: context) as? HashtagMentions {
                hashtagMention.text = hashtag.keyword
                hashtagMention.count = 1
                return hashtagMention
            }
        }
        return nil
        
    }
}
