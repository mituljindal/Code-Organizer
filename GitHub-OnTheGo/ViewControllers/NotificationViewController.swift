//
//  NotificationViewController.swift
//  GitHub-OnTheGo
//
//  Created by mitul jindal on 16/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit

class NotificationViewController: UITableViewController {
    
    let notificationClient = GitHubNotificationClient.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationClient.getNotifications() {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationClient.notifications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath)
        
        cell.textLabel?.text = notificationClient.notifications[indexPath.row].title
        
        if let detail = notificationClient.notifications[indexPath.row].name {
            cell.detailTextLabel?.text = detail
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
