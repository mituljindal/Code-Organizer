//
//  GitHubClient.swift
//  GitHub-OnTheGo
//
//  Created by mitul jindal on 11/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit
import Alamofire

class GitHubClient {
    
    static let sharedInstance = GitHubClient()
    var OAuthToken: String?
    
    func hasAuthToken() {
        
    }
    
    func startOAuth2Login() {
        
    }
    
    func getAuthUrl() -> URL {
        var urlString = AuthValues.authURL + "?" + AuthKeys.clientID + "=" + AuthValues.clientID
        urlString = "\(urlString)&\(AuthKeys.redirectURL)=\(AuthValues.redirectURL)&\(AuthKeys.state)=\(AuthValues.state)"
        urlString += "&scope=repo,admin:org,admin:public_key,user,delete_repo"
        return URL(string: urlString)!
    }
    
    func processOAuthStep1Response(url: URL, completion: @escaping ((_ complete: Bool) -> (Void)))
    {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        var code:String?
        if let queryItems = components?.queryItems {
            for queryItem in queryItems {
                if (queryItem.name.lowercased() == "code") {
                    code = queryItem.value
                    break
                }
            }
        }
        
        if let receivedCode = code {
            
            let getTokenPath:String = "https://github.com/login/oauth/access_token"
            let tokenParams = ["client_id": AuthValues.clientID, "client_secret": AuthValues.clientSecret, "code": receivedCode, "scope": AuthValues.state]
            Alamofire.request(getTokenPath, method: .post, parameters: tokenParams)
                .validate()
                .responseString { (response) in
                    
                    if let error = response.error {
                        print(error)
                        DispatchQueue.main.async {
                            completion(false)
                        }
                        return
                    }
                    if let receivedResults = response.result.value {
                    
                        let resultParams = receivedResults.split(separator: "&")
                        for param in resultParams {
                            let resultsSplit = param.split(separator: "=")
                            let key = resultsSplit[0].lowercased()
                            let value = resultsSplit[1]
                            switch key {
                                case "access_token":
                                    self.OAuthToken = String(value)
                                default:
                                    print("")
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        completion(true)
                    }
            }
        }
    }
}
