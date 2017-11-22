//
//  ContentDisplayViewController.swift
//  CodeOrganizer
//
//  Created by mitul jindal on 14/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit

class ContentDisplayViewController: UIViewController {
    
    @IBOutlet weak var contentTextView: UITextView!
    var content: Content!
    let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = content.name
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = self.view.center
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.view.addSubview(activityIndicator)

        activityIndicator.startAnimating()
        
//        Get File content and display
        github.downloadText(content: content) { error in
            self.activityIndicator.stopAnimating()
            
            if let _ = error {
                self.presentAlert(title: "An Error Occurred", error: "Please try again")
                return
            }
            
            self.contentTextView.text = self.content.text
        }
    }
}
