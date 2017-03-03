//
//  TwitterUser+CoreDataProperties.swift
//  Smashtag
//
//  Created by Marc FAMILARI on 3/3/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension TwitterUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TwitterUser> {
        return NSFetchRequest<TwitterUser>(entityName: "TwitterUser");
    }

    @NSManaged public var name: String?
    @NSManaged public var screenName: String?
    @NSManaged public var tweets: NSSet?
    @NSManaged public var hashtagMentions: NSSet?

}

// MARK: Generated accessors for tweets
extension TwitterUser {

    @objc(addTweetsObject:)
    @NSManaged public func addToTweets(_ value: Tweet)

    @objc(removeTweetsObject:)
    @NSManaged public func removeFromTweets(_ value: Tweet)

    @objc(addTweets:)
    @NSManaged public func addToTweets(_ values: NSSet)

    @objc(removeTweets:)
    @NSManaged public func removeFromTweets(_ values: NSSet)

}

// MARK: Generated accessors for hashtagMentions
extension TwitterUser {

    @objc(addHashtagMentionsObject:)
    @NSManaged public func addToHashtagMentions(_ value: HashtagMention)

    @objc(removeHashtagMentionsObject:)
    @NSManaged public func removeFromHashtagMentions(_ value: HashtagMention)

    @objc(addHashtagMentions:)
    @NSManaged public func addToHashtagMentions(_ values: NSSet)

    @objc(removeHashtagMentions:)
    @NSManaged public func removeFromHashtagMentions(_ values: NSSet)

}
