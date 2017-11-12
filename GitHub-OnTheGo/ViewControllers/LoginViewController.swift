//
//  ViewController.swift
//  GitHub-OnTheGo
//
//  Created by mitul jindal on 10/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit
import Firebase
import Alamofire

class LoginViewController: UIViewController {
    
    let gitHub = GitHubClient.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var token: String
        if let _ = UserDefaults.standard.object(forKey: "JWT") {
            token = UserDefaults.standard.object(forKey: "JWT") as! String
            print("token: \(token)")
        } else {
            print("No token")
        }
        
//        let parameters: [String: Any] = [
//            "name": "OnTheGo-GitHub",
//            "description": "This is my first complete app",
//            "homepage": "",
//            "private": false,
//            "has_issues": true,
//            "has_projects": false,
//            "has_wiki": true
//        ]
//        let header: HTTPHeaders = ["Authorization": "token \(token)"]
//        Alamofire.request("https://api.github.com/user/repos", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header)
////            .validate()
//            .responseJSON { response in
//            print("response.request \(response.request)")  // original URL request
//            print("response.response \(response.response)") // HTTP URL response
//            print("response.data \(response.data)")     // server data
//            print("response.result \(response.result)")
//
//            print("response \(response)")
//
//        }
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        present(controller, animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
