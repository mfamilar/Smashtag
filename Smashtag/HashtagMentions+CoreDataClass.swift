//
//  HashtagMentions+CoreDataClass.swift
//  Smashtag
//
//  Created by Marc FAMILARI on 3/1/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData
import Twitter

@objc(HashtagMentions)
public class HashtagMentions: NSManagedObject {

    class func tweetWithTwitterInfo(twitterInfo: Twitter.Tweet, inManagedObjectContext context: NSManagedObjectContext) -> HashtagMentions? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HashtagMention")
//        request.predicate = NSPredicate(format: "mention = %@", twitterInfo.media.)
        return nil
    }
    
}