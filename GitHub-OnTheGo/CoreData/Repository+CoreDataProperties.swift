//
//  Repository+CoreDataProperties.swift
//  
//
//  Created by mitul jindal on 14/11/17.
//
//

import Foundation
import CoreData


extension Repository {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Repository> {
        return NSFetchRequest<Repository>(entityName: "Repository")
    }

    @NSManaged public var descriptionString: String?
    @NSManaged public var forks: Int32
    @NSManaged public var id: Int64
    @NSManaged public var isFork: Bool
    @NSManaged public var isPrivate: Bool
    @NSManaged public var language: String?
    @NSManaged public var name: String?
    @NSManaged public var stargazers: Int32
    @NSManaged public var urlString: String?
    @NSManaged public var watchers: Int32

}
