//
//  RepositoryDataViewController.swift
//  GitHub-OnTheGo
//
//  Created by mitul jindal on 14/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit

class RepositoryDataViewController: UITableViewController {
    
    var index: Int!
    var repo: Repository!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = repo.getType(index: index)
        getData()
    }
    
    func getData() {
        
        github.getDetails(repo: repo, index: index) {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repo.list[index]!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath)
        
        cell.textLabel?.text = repo.list[index]![indexPath.row]
        return cell
    }
}
