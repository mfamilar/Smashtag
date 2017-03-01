//
//  HashtagMentions+CoreDataProperties.swift
//  Smashtag
//
//  Created by Marc FAMILARI on 3/1/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension HashtagMentions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HashtagMentions> {
        return NSFetchRequest<HashtagMentions>(entityName: "HashtagMentions");
    }

    @NSManaged public var counted: Bool
    @NSManaged public var text: String?
    @NSManaged public var tweet: Tweet?

}
