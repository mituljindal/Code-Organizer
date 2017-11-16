//
//  GitHubProfile.swift
//  GitHub-OnTheGo
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
                
                let _ = User(json: result, context: self.context)
                
                do {
                    try self.context.execute(batchDeleteRequest)
                } catch {
                    print("couldn't find object")
                }
                
                DispatchQueue.main.async {
                    completion()
                }
        }
    }
}
