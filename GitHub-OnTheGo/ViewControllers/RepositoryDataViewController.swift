//
//  RepositoryDataViewController.swift
//  GitHub-OnTheGo
//
//  Created by mitul jindal on 14/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit

class RepositoryDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var index: Int!
    var repo: Repository!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = repo.getType(index: index)
        label.text = "No \(title)"
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = self.view.center
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.view.addSubview(activityIndicator)
        
        self.view.backgroundColor = .githubBackground
        
        self.navigationItem.title = title
        
//        Get Data
        github.getDetails(repo: repo, index: index) { error in
            self.activityIndicator.stopAnimating()
            
            if let _ = error {
                self.presentAlert(title: "Error Occurred", error: "Please try again!")
                return
            }
            
            if self.repo.list[self.index]!.count == 0 {
                self.tableView.isHidden = true
                self.label.isHidden = false
            } else {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if repo.list[index]!.count == 0 {
            activityIndicator.startAnimating()
        }
        return repo.list[index]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath)
        
        cell.textLabel?.text = repo.list[index]![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
