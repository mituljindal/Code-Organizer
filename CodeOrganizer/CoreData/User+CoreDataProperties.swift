//
//  User+CoreDataProperties.swift
//  
//
//  Created by mitul jindal on 16/11/17.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var username: String?
    @NSManaged public var email: String?
    @NSManaged public var imageURL: String?

}
