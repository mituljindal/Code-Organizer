//
//  RepositoryViewController.swift
//  GitHub-OnTheGo
//
//  Created by mitul jindal on 13/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit

class RepositoryViewController: UIViewController {
    
    var repo: Repository!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = repo.name
    }
}
