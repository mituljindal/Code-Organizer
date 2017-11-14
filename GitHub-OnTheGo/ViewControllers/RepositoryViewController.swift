//
//  RepositoryViewController.swift
//  GitHub-OnTheGo
//
//  Created by mitul jindal on 13/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit

class RepositoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var starsTextView: CustomUITextView!
    @IBOutlet weak var forksTextView: CustomUITextView!
    @IBOutlet weak var watchersTextView: CustomUITextView!
    
    @IBOutlet weak var publicTextView: CustomUITextView!
    @IBOutlet weak var languageTextView: CustomUITextView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var repo: Repository!
    
//    let optionsArray = ["Issues", "Branches", "Commits", "Pull Requests", "Source"]
    
    override func viewDidLoad() {
        starsTextView.text = "\(repo.stargazers)\nStars"
        forksTextView.text = "\(repo.forks)\nForks"
        watchersTextView.text = "\(repo.watchers)\nWatchers"
        
        publicTextView.text = repo.isPrivate ? "Private": "Public"
        
        languageTextView.text = repo.language
        
        
        tableView.bounces = false
        
        super.viewDidLoad()
        
        self.navigationItem.title = repo.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        publicTextView.centerTextVertically()
        languageTextView.centerTextVertically()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LinkCells", for: indexPath)
        
        cell.textLabel?.text = repo.getType(indexPath: indexPath)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "RepositoryDataViewController") as! RepositoryDataViewController
        
        controller.indexPath = indexPath
        controller.repo = repo
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
