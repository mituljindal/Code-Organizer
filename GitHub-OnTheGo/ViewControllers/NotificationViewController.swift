//
//  NotificationViewController.swift
//  GitHub-OnTheGo
//
//  Created by mitul jindal on 16/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let notificationClient = GitHubNotificationClient.shared
    let activityIndicator = UIActivityIndicatorView()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = self.view.center
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.view.addSubview(activityIndicator)
        
        label.isHidden = true
        self.view.backgroundColor = .githubBackground
        
        notificationClient.getNotifications() { error in
            self.activityIndicator.stopAnimating()
            
            if let _ = error {
                self.presentAlert(title: "An error occured", error: "Please try again!")
                return
            }
            
            if self.notificationClient.notifications.count == 0 {
                self.tableView.isHidden = true
                self.label.isHidden = false
            } else {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if notificationClient.notifications.count == 0 {
            activityIndicator.startAnimating()
        }
        return notificationClient.notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath)
        
        cell.textLabel?.text = notificationClient.notifications[indexPath.row].title
        
        if let detail = notificationClient.notifications[indexPath.row].name {
            cell.detailTextLabel?.text = detail
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
