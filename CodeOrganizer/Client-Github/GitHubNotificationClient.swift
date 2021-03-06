//
//  GitHubNotifications.swift
//  CodeOrganizer
//
//  Created by mitul jindal on 16/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import Foundation
import Alamofire

class GitHubNotificationClient: GitHubClient {
    
    struct Notification {
        var title: String
        var name: String?
    }
    
    static var shared = GitHubNotificationClient()
    
    var github = GitHubClient.sharedInstance
    
    
    var notifications = [Notification]()
    
    func getNotifications(completion: @escaping (_ error: Bool?) -> ()) {
        
        let url = API.url + "/notifications?all=true"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: github.header)
            .validate()
            .responseJSON() { response in
                
                func sendError() {
                    DispatchQueue.main.async {
                        completion(true)
                    }
                }
                
                if let error = response.error {
                    print("error: \(error)")
                    sendError()
                    return
                }
                
                guard let data = response.data else {
                    print("couldn't get data")
                    sendError()
                    return
                }
                
                var results: [[String: Any]]
                do {
                    results = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String : Any]]
                } catch {
                    print("Couldn't parse data")
                    sendError()
                    return
                }
                
                for result in results {
                    guard let subject = result["subject"] as? [String: Any] else {
                        print("no subject")
                        continue
                    }
                    guard let title = subject["title"] as? String else {
                        print("no title")
                        continue
                    }
                    var name: String?
                    if let repository = result["repository"] as? [String: Any] {
                        name = repository["full_name"] as? String
                    }
                    
                    let notification = Notification(title: title, name: name)
                    self.notifications.append(notification)
                }
                DispatchQueue.main.async {
                    completion(nil)
                }
        }
    }
}
