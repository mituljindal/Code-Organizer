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
    
    func getRepositories(type: RepoType, completion: @escaping () -> ()) {
        
        var url = API.url
        
        switch type {
        case .starred:
            url += API.starredReps
        case .owned:
            url += API.userReps
        default:
            return
        }
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
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
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Repository")
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
                fetchRequest.predicate = NSPredicate(format: "\(type) == %@", argumentArray: [true])
                
                let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                
                do {
                    try self.context.execute(batchDeleteRequest)
                } catch {
                    print("couldn't find object")
                }
                
                do {
                    let results = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String: Any]]
                    
                    for result in results {
                        let _ = Repository(json: result, save: true, type: type, context: self.context)
                    }
                    do {
                        try self.stack.saveContext()
                    } catch {
                        print("save unsuccessful")
                    }
                    DispatchQueue.main.async {
                        completion()
                    }
                    
                } catch {
                    return
                }
            }
    }
    
    func getDetails(repo: Repository, index: Int, completion: @escaping () -> ()) {

        let url = repo.urlString! + repo.getUrlPath(index)

        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseJSON() { response in

                if let error = response.error {
                    print("error: \(error)")
                }
                
                do {
                    guard let data = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as? [[String: Any]] else {
                        return
                    }
                    
                    var list = [String]()
                    switch(index) {
                    case 0:
                        for item in data {
                            list.append(item["title"] as? String ?? "")
                        }
                    case 1:
                        for item in data {
                            list.append(item["name"] as? String ?? "")
                        }
                    case 2:
                        for item in data {
                            let commit = item["commit"] as! [String: Any]
                            list.append(commit["message"] as? String ?? "")
                        }
                    case 3:
                        for item in data {
                            list.append(item["title"] as? String ?? "")
                        }
//                    case 4:
//                        for item in data {
//                            let str = item["name"] as? String ?? ""
//                            list.append(str)
//
//                            let x = self.parseContent(item: item)
//
//                            repo.content[str] = x
//                        }
                    default:
                        fatalError("Extraneous index")
                    }
                    
                    repo.list[index] = list
                    DispatchQueue.main.async {
                        completion()
                    }
                } catch {
                    return
                }
                

            }
    }
    
    func getContent(content: Content, completion: @escaping () -> ()) {
        
        let url = content.url!
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseJSON() { response in
                
                if let error = response.error {
                    print("error: \(error)")
                    return
                }
                
                guard let data = response.data else {
                    print("no data")
                    return
                }
                
                var result: [[String: Any]]
                
                do {
                    result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String: Any]]
                } catch {
                    print("couldn't convert data")
                    return
                }
                
                content.content = [Content]()
                
                for item in result {
                    let temp = Content()
                    temp.name = item["name"] as! String
                    temp.url = item["url"] as! String
                    temp.downloadURL = item["download_url"] as? String
                    temp.content = [Content]()
                    content.content?.append(temp)
                }
                
                DispatchQueue.main.async {
                    completion()
                }
        }
    }
    
    func downloadText(content: Content, completion: @escaping () -> ()) {
        
        let url = content.downloadURL!
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseString() { response in
                
                content.text = response.value
                completion()
        }
    }
}
