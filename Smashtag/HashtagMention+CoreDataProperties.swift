//
//  HashtagMention+CoreDataProperties.swift
//  Smashtag
//
//  Created by Marc FAMILARI on 3/3/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension HashtagMention {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HashtagMention> {
        return NSFetchRequest<HashtagMention>(entityName: "HashtagMention");
    }

    @NSManaged public var count: Int64
    @NSManaged public var mention: String?
    @NSManaged public var tweet: Tweet?
    @NSManaged public var tweeter: TwitterUser?

}
