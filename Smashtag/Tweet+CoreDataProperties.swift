//
//  Tweet+CoreDataProperties.swift
//  Smashtag
//
//  Created by Marc FAMILARI on 3/3/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Tweet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tweet> {
        return NSFetchRequest<Tweet>(entityName: "Tweet");
    }

    @NSManaged public var posted: NSDate?
    @NSManaged public var text: String?
    @NSManaged public var unique: String?
    @NSManaged public var hashtags: NSSet?
    @NSManaged public var tweeter: TwitterUser?

}

// MARK: Generated accessors for hashtags
extension Tweet {

    @objc(addHashtagsObject:)
    @NSManaged public func addToHashtags(_ value: HashtagMention)

    @objc(removeHashtagsObject:)
    @NSManaged public func removeFromHashtags(_ value: HashtagMention)

    @objc(addHashtags:)
    @NSManaged public func addToHashtags(_ values: NSSet)

    @objc(removeHashtags:)
    @NSManaged public func removeFromHashtags(_ values: NSSet)

}
