//
//  RepositoryViewController.swift
//  GitHub-OnTheGo
//
//  Created by mitul jindal on 12/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit

class RepositoryViewController: UIViewController {
    
    
    override func viewDidLoad() {
        
        github.getRepositories()
    }
}
