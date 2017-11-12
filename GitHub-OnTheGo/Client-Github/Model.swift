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
        
        var name: String
        var fullName: String
        var isPrivate: Bool
        var description: String?
        var isFork: Bool
//        var createdAt: Date
        var stargazers: Int
        var watchers: Int
        var forks: Int
        var language: String
        
        init(json: [String: Any]) {
            name = json["name"] as? String ?? ""
            fullName = json["full_name"] as? String ?? ""
            isPrivate = json["private"] as? Bool ?? false
            description = json["description"] as? String
            isFork = json["fork"] as? Bool ?? false
//            createdAt
            stargazers = json["stargazers_count"] as? Int ?? 0
            watchers = json["watchers_count"] as? Int ?? 1
            forks = json["forks_count"] as? Int ?? 0
            language = json["language"] as? String ?? ""
        }
    }
}
