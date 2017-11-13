//
//  Repository+CoreDataClass.swift
//  
//
//  Created by mitul jindal on 13/11/17.
//
//

import Foundation
import CoreData

@objc(Repository)
public class Repository: NSManagedObject {

    convenience init(repository: GitHubClient.GRepository, context: NSManagedObjectContext) {
        
        if let ent = NSEntityDescription.entity(forEntityName: "Repository", in: context) {
//            Default init
            self.init(entity: ent, insertInto: context)
            
            self.id = repository.id
            self.descriptionString = repository.descriptionString
            self.forks =  repository.forks
            self.fullName = repository.fullName
            self.isFork = repository.isFork
            self.isPrivate = repository.isPrivate
            self.language = repository.language
            self.name = repository.name
            self.stargazers = repository.stargazers
            self.watchers = repository.watchers
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
    
    convenience init(json: [String: Any], context: NSManagedObjectContext) {
        
        if let ent = NSEntityDescription.entity(forEntityName: "Repository", in: context) {
            self.init(entity: ent, insertInto: context)
            
            id = json["id"] as! Int64
            name = json["name"] as? String ?? ""
            fullName = json["full_name"] as? String ?? ""
            isPrivate = json["private"] as? Bool ?? false
            descriptionString = json["description"] as? String
            isFork = json["fork"] as? Bool ?? false
            stargazers = json["stargazers_count"] as? Int32 ?? 0
            watchers = json["watchers_count"] as? Int32 ?? 1
            forks = json["forks_count"] as? Int32 ?? 0
            language = json["language"] as? String ?? ""
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
}
