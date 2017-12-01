//
//  GitHubProfile.swift
//  CodeOrganizer
//
//  Created by mitul jindal on 16/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

extension GitHubClient {
    
    func getUserInfo(completion: @escaping () -> ()) {
        
        let url = API.url + "/user"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseJSON() { response in
                
                if let error = response.error {
                    print("error: \(error)")
                    return
                }
                
                guard let data = response.data else {
                    print("No data received")
                    return
                }
                
                var result: [String: Any]
                do {
                    result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
                } catch {
                    print("Couldn't serialize data")
                    return
                }
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
                
                let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                
                do {
                    try self.stack.context.execute(batchDeleteRequest)
                } catch {
                    print("couldn't find object")
                }
                
                let _ = User(json: result, context: self.stack.context)
                
                do {
                    try self.stack.context.save()
                } catch {
                    print("couldn't save context")
                }
                
                DispatchQueue.main.async {
                    completion()
                }
        }
    }
    
    func logout(completion: @escaping () -> ()) {
        
        self.OAuthToken = nil
        GitHubNotificationClient.shared = GitHubNotificationClient()
        GitHubSearchClient.shared = GitHubSearchClient()
        
        UserDefaults.standard.set(nil, forKey: "JWT")
        
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Repository")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        var batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try self.stack.context.execute(batchDeleteRequest)
        } catch {
            print("couldn't find Repository")
        }
        
        fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try self.stack.context.execute(batchDeleteRequest)
        } catch {
            print("couldn't find User")
        }
        
        do {
            try self.stack.context.save()
        } catch {
            print("couldn't save context")
        }
        
        completion()
    }
}
