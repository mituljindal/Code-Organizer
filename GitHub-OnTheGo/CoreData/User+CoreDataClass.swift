//
//  User+CoreDataClass.swift
//  
//
//  Created by mitul jindal on 16/11/17.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {

    convenience init(json: [String: Any], context: NSManagedObjectContext) {
        
        if let ent = NSEntityDescription.entity(forEntityName: "User", in: context) {
            self.init(entity: ent, insertInto: context)
            
            self.name = json["name"] as? String
            self.username = json["login"] as? String
            self.email = json["email"] as? String
            self.imageURL = json["avatar_url"] as? String
            
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
}
