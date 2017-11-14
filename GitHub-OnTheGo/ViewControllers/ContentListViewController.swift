//
//  ContentListViewController.swift
//  GitHub-OnTheGo
//
//  Created by mitul jindal on 14/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit

class ContentListViewController: UITableViewController {
    
//    var repo: Repository!
    var content: Content!
    
    override func viewDidLoad() {
        
        github.getContent(content: content) {
            self.tableView.reloadData()
        }
        
        super.viewDidLoad()
        
        self.navigationItem.title = content.name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.content!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath)
        
        cell.textLabel?.text = content.content![indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if content.content![indexPath.row].downloadURL != nil {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "ContentDisplayViewController") as! ContentDisplayViewController
            
            controller.content = content.content![indexPath.row]
            self.navigationController?.pushViewController(controller, animated: true)
            
        } else {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "ContentListViewController") as! ContentListViewController
            
            controller.content = content.content![indexPath.row]
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    
}
