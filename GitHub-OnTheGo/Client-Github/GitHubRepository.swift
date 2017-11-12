//
//  GitHubRepository.swift
//  GitHub-OnTheGo
//
//  Created by mitul jindal on 13/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import Foundation
import Alamofire

extension GitHubClient {
    
    func getRepositories() {
        Alamofire.request(API.url + API.userReps, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseJSON() { response in
                if let error = response.error {
                    print("error: \(error)")
                }
                
                var results: [[String: Any]]
                if let data = response.data {
                    do {
                        results = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String: Any]]
                        var respositories = [GRepository]()
                        for result in results {
                            respositories.append(GRepository(json: result))
                        }
                        print("reps: \(respositories)")
                    } catch {
                        return
                    }
                } else {
                    print("Can't convert any to Data")
                }
        }
    }
}
