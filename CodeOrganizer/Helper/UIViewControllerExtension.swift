//
//  UIViewControllerExtension.swift
//  CodeOrganizer
//
//  Created by mitul jindal on 12/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit

extension UIViewController {
    
//    created GitHubClient and AppDelegate instances so that it's not required to create in every view controller
    
    var github: GitHubClient {
        get {
            return GitHubClient.sharedInstance
        }
    }
    
//    For presenting alerts
    func presentAlert(title: String, error: String) {
        let ac = UIAlertController(title: title, message: error, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
    }
}
