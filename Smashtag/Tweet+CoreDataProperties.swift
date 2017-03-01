//
//  Tweet+CoreDataProperties.swift
//  Smashtag
//
//  Created by Marc FAMILARI on 3/1/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Tweet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tweet> {
        return NSFetchRequest<Tweet>(entityName: "Tweet");
    }

    @NSManaged public var text: String?
    @NSManaged public var unique: String?
    @NSManaged public var posted: NSDate?
    @NSManaged public var tweeter: TwitterUser?
    @NSManaged public var mentions: NSSet?

}

// MARK: Generated accessors for mentions
extension Tweet {

    @objc(addMentionsObject:)
    @NSManaged public func addToMentions(_ value: HashtagMentions)

    @objc(removeMentionsObject:)
    @NSManaged public func removeFromMentions(_ value: HashtagMentions)

    @objc(addMentions:)
    @NSManaged public func addToMentions(_ values: NSSet)

    @objc(removeMentions:)
    @NSManaged public func removeFromMentions(_ values: NSSet)

}
