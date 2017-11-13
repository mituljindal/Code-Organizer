//
//  GitHubRepository.swift
//  GitHub-OnTheGo
//
//  Created by mitul jindal on 13/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

extension GitHubClient {
    
    func getRepositories(completion: @escaping () -> ()) {
        Alamofire.request(API.url + API.userReps, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseJSON() { response in
                if let error = response.error {
                    print("error: \(error)")
                }
                
                var results: [[String: Any]]
                guard let data = response.data else {
                    print("Can't convert any to Data")
                    return
                }
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Repository")
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
                
                let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                
                do {
                    try self.context.execute(batchDeleteRequest)
                } catch {
                    print("couldn't find object")
                }
                
                do {
                    results = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String: Any]]
                    
                    for result in results {
                        let _ = Repository(json: result, context: self.context)
                    }
                    do {
                        try self.stack.saveContext()
                    } catch {
                        print("save unsuccessful")
                    }
                    completion()
                    
                } catch {
                    return
                }
            }
    }
}
