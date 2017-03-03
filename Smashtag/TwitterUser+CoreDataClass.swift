//
//  TwitterUser+CoreDataClass.swift
//  Smashtag
//
//  Created by Marc FAMILARI on 3/3/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData
import Twitter

@objc(TwitterUser)
public class TwitterUser: NSManagedObject {

    class func twitterUserWithTwitterInfo(twitterInfo: Twitter.User, inManagedObjectContext context: NSManagedObjectContext) -> TwitterUser? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TwitterUser")
        request.predicate = NSPredicate(format: "screenName = %@", twitterInfo.screenName)
        if let twitterUser = (try? context.fetch(request))?.first as? TwitterUser {
            return twitterUser
        } else if let twitterUser = NSEntityDescription.insertNewObject(forEntityName: "TwitterUser", into: context) as? TwitterUser {
            twitterUser.name = twitterInfo.name
            twitterUser.screenName = twitterInfo.screenName
            return twitterUser
        }
        return nil
    }
    
}
