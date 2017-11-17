//
//  Content.swift
//  GitHub-OnTheGo
//
//  Created by mitul jindal on 14/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import Foundation

// Required for managing source code files
class Content {
    
    public var name: String!
    public var url: String!
    public var downloadURL: String?
    public var text: String?
    
    public var content: [Content]?
}

enum RepoType: String {
    case owned, starred, bookmarked
}
