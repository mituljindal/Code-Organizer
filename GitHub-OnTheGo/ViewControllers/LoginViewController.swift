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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        If OAuth token is present, present repositories
        if super.github.hasAuthToken() {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "loggedIn") as! UINavigationController
            present(controller, animated: false, completion: nil)
        }
    }
    
//    Open webview for Authentication
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        controller.getOAuthUrl()
        present(controller, animated: true, completion: nil)
    }
}
