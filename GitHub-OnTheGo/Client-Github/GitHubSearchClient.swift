//
//  GitHubSearchClient.swift
//  GitHub-OnTheGo
//
//  Created by mitul jindal on 15/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import Foundation
import Alamofire

class GitHubSearchClient: GitHubClient {
    
    var repos = [Repository]()
    static var shared = GitHubSearchClient()
    let github = GitHubClient.sharedInstance
    
    func searchRepositories(query: String, completion: @escaping () -> ()) {
        
        let url = API.url + "/search/repositories?q=\(query)"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: github.header)
            .validate()
            .responseJSON() { response in
                
                if let error = response.error {
                    print("error: \(error)")
                    return
                }
                
                guard let data = response.data else {
                    print("Can't convert any to Data")
                    return
                }
                
                do {
                    let results = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
                    
                    guard let items = results["items"] as? [[String: Any]] else {
                        print("no items")
                        return
                    }
                    
                    self.repos = [Repository]()
                    
                    for item in items {
                        let repo = Repository(json: item, save: true, type: nil, context: self.stack.context)
                        self.repos.append(repo)
                    }
                    
                    DispatchQueue.main.async {
                        completion()
                    }
                    
                } catch {
                    return
                }
        }
    }
    
    func clearRepos(completion: @escaping () -> ()) {
        repos = [Repository]()
        completion()
    }
}

