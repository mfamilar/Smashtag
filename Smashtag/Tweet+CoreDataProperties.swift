//
//  Tweet+CoreDataProperties.swift
//  Smashtag
//
//  Created by Marc FAMILARI on 3/2/17.
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
    @NSManaged public var mentions: HashtagMentions?
    @NSManaged public var tweeter: TwitterUser?

}
