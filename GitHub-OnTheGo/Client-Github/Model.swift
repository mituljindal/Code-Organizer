//
//  Model.swift
//  GitHub-OnTheGo
//
//  Created by mitul jindal on 13/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import Foundation

extension GitHubClient {
    
    struct GRepository {
        
        var id: Int64
        var name: String
        var fullName: String
        var isPrivate: Bool
        var descriptionString: String?
        var isFork: Bool
//        var createdAt: Date
        var stargazers: Int32
        var watchers: Int32
        var forks: Int32
        var language: String
        
        init(json: [String: Any]) {
            id = json["id"] as! Int64
            name = json["name"] as? String ?? ""
            fullName = json["full_name"] as? String ?? ""
            isPrivate = json["private"] as? Bool ?? false
            descriptionString = json["description"] as? String
            isFork = json["fork"] as? Bool ?? false
//            createdAt
            stargazers = json["stargazers_count"] as? Int32 ?? 0
            watchers = json["watchers_count"] as? Int32 ?? 1
            forks = json["forks_count"] as? Int32 ?? 0
            language = json["language"] as? String ?? ""
        }
    }
}
