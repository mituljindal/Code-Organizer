//
//  ContentDisplayViewController.swift
//  GitHub-OnTheGo
//
//  Created by mitul jindal on 14/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit

class ContentDisplayViewController: UIViewController {
    
    @IBOutlet weak var contentTextView: UITextView!
    var content: Content!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = content.name
        
//        Get File content and display
        github.downloadText(content: content) {
            print("in completion")
            self.contentTextView.text = self.content.text
        }
    }
}
