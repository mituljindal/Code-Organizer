//
//  NavigationControllerExtension.swift
//  CodeOrganizer
//
//  Created by mitul jindal on 13/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.delegate = self
    }
    
//    To remove the back button title
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
}
