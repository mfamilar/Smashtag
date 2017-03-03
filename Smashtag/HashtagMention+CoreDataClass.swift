//
//  HashtagMention+CoreDataClass.swift
//  Smashtag
//
//  Created by Marc FAMILARI on 3/3/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData
import Twitter

@objc(HashtagMention)
public class HashtagMention: NSManagedObject {

//    class func hashtagMentionWithTwitterInfo(twitterInfo: Twitter.Tweet, inManagedObjectContext context: NSManagedObjectContext) -> NSSet? {
//        print("        USER = \(twitterInfo.user.name)")
//        for hashtag in twitterInfo.hashtags {
//            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HashtagMentions")
//            request.predicate = NSPredicate(format: "text = %@", hashtag.keyword)
//            if let hashtagMention = (try? context.fetch(request))?.first as? HashtagMention {
//                hashtagMention.count += 1
//                print("        COUNT = \( hashtagMention.count)          ")
//                return hashtagMention
//            }
//            if let hashtagMention = NSEntityDescription.insertNewObject(forEntityName: "HashtagMentions", into: context) as? HashtagMention {
//                hashtagMention.mention = hashtag.keyword
//                hashtagMention.count = 1
//                print("        HASH = \( hashtag.keyword)")
//                return Set<hashtagMention>
//            }
//        }
//        return nil
//    }
    
}
