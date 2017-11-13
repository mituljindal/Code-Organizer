//
//  UIViewControllerExtension.swift
//  GitHub-OnTheGo
//
//  Created by mitul jindal on 12/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var github: GitHubClient {
        get {
            return GitHubClient.sharedInstance
        }
    }
    
    var appDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
    
    func presentAlert(title: String, error: String) {
        let ac = UIAlertController(title: title, message: error, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
    }
}
