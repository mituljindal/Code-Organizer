//
//  ContentListViewController.swift
//  GitHub-OnTheGo
//
//  Created by mitul jindal on 14/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit

class ContentListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var content: Content!
    let activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = self.view.center
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.view.addSubview(activityIndicator)
        
        self.view.backgroundColor = .githubBackground
        
//        Get Data
        github.getContent(content: content) {
            self.activityIndicator.stopAnimating()
            if self.content.content!.count == 0 {
                self.tableView.isHidden = true
                self.label.isHidden = false
            } else {
                self.tableView.reloadData()
            }
        }
        
        super.viewDidLoad()
        self.navigationItem.title = content.name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if content.content!.count == 0 {
            activityIndicator.startAnimating()
        }
        return content.content!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath)
        
        cell.textLabel?.text = content.content![indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        If file
        if content.content![indexPath.row].downloadURL != nil {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "ContentDisplayViewController") as! ContentDisplayViewController
            
            controller.content = content.content![indexPath.row]
            self.navigationController?.pushViewController(controller, animated: true)
            
//            If Directory
        } else {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "ContentListViewController") as! ContentListViewController
            
            controller.content = content.content![indexPath.row]
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    
}
