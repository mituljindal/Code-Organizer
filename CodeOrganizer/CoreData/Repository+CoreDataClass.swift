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
    
    var list = [Int: [String]]()
    var content = Content()
    
    convenience init(json: [String: Any], save: Bool, type: RepoType?, context: NSManagedObjectContext) {
        
        if let ent = NSEntityDescription.entity(forEntityName: "Repository", in: context) {
            if save {
                self.init(entity: ent, insertInto: context)
            } else {
                self.init(entity: ent, insertInto: nil)
            }
            
            if let type = type {
                switch(type) {
                case .owned:
                    owned = true
                case .starred:
                    starred = true
                default:
                    print("wrong type")
                }
            }
            
            name = json["name"] as? String ?? ""
            urlString = json["url"] as? String ?? ""
            isPrivate = json["private"] as? Bool ?? false
            descriptionString = json["description"] as? String
            stargazers = json["stargazers_count"] as? Int32 ?? 0
            watchers = json["watchers_count"] as? Int32 ?? 1
            forks = json["forks_count"] as? Int32 ?? 0
            language = json["language"] as? String ?? ""
            if let owner = json["owner"] as? [String: Any] {
                ownerName = owner["login"] as? String ?? ""
            } else {
                ownerName = ""
            }
            
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
    
//    Custom init
    func custInit() {
//        Initializing empty dictionary for details other than Source(Content)
        for i in 0..<4 {
            list[i] = [String]()
        }
        
//        Initializing empty first content array
        content.name = "Source"
        content.downloadURL = nil
        content.url = urlString! + "/contents"
        content.content = [Content]()
    }
    
//    For displaying different types
    func getType(index: Int) -> String {
        
        switch index {
        case 0:
            return "Issues"
        case 1:
            return "Branches"
        case 2:
            return "Commits"
        case 3:
            return "Pull Requests"
        case 4:
            return "Source"
        default:
            return ""
        }
    }
    
//    For constructing urls
    func getUrlPath(_ index: Int) -> String {
        
        switch index {
        case 0:
            return "/issues"
        case 1:
            return "/branches"
        case 2:
            return "/commits"
        case 3:
            return "/pulls"
        default:
            return ""
        }
    }
    
}
