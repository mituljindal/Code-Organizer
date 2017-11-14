//
//  RepositoryDataViewController.swift
//  GitHub-OnTheGo
//
//  Created by mitul jindal on 14/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit

class RepositoryDataViewController: UITableViewController {
    
    var indexPath: IndexPath!
    var list = [String]()
    var repo: Repository!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = repo.getType(indexPath: indexPath)
        getData()
    }
    
    func getData() {
        print("getting data")
//        github.getDetails(repo: repo, type: type) { list in
//            self.list = list
//        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath)
        
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
}
