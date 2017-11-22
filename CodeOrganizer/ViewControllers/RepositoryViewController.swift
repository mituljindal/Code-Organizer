//
//  RepositoryViewController.swift
//  CodeOrganizer
//
//  Created by mitul jindal on 13/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit
import CoreData

class RepositoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var starsTextView: CustomUITextView!
    @IBOutlet weak var forksTextView: CustomUITextView!
    @IBOutlet weak var watchersTextView: CustomUITextView!
    
    @IBOutlet weak var publicTextView: CustomUITextView!
    @IBOutlet weak var languageTextView: CustomUITextView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var ownerTextView: CustomUITextView!
    
    var repo: Repository!
    
    var launch = true
    
    let saveButton = UIBarButtonItem(image: UIImage(named: "icons8-repository"), style: .plain, target: nil, action: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Setting data values
        starsTextView.text = "\(repo.stargazers)\nStars"
        forksTextView.text = "\(repo.forks)\nForks"
        watchersTextView.text = "\(repo.watchers)\nWatchers"
        
        publicTextView.text = repo.isPrivate ? "Private": "Public"
        languageTextView.text = repo.language
        
        ownerTextView.text = "Owner: \(repo.ownerName!)"
        
        tableView.bounces = false
        
        if repo.bookmarked {
            saveButton.image =  UIImage(named: "icons8-repository-2")
        } else {
            saveButton.image =  UIImage(named: "icons8-repository")
        }
        
        self.navigationItem.title = repo.name
        self.navigationItem.rightBarButtonItem = saveButton
        
        saveButton.target = self
        saveButton.action = #selector(saveButtonPressed)
        
//        For detail views data initialization
        repo.custInit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        Vertically center align the text views
        publicTextView.centerTextVertically()
        languageTextView.centerTextVertically()
        ownerTextView.centerTextVertically()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        Vertically center align the text views
        publicTextView.centerTextVertically()
        languageTextView.centerTextVertically()
        ownerTextView.centerTextVertically()
    }
    
    @objc func saveButtonPressed() {
        if repo.bookmarked {
            repo.bookmarked = false
            saveButton.image =  UIImage(named: "icons8-repository")
            
            if !repo.starred && !repo.owned {
                github.stack.context.delete(repo)
            }
            
        } else {
            repo.bookmarked = true
            saveButton.image =  UIImage(named: "icons8-repository-2")
            if !repo.starred && !repo.owned {
                let newRepo = NSEntityDescription.insertNewObject(forEntityName: "Repository", into: github.stack.context) as! Repository
                newRepo.name = repo.name
                newRepo.bookmarked = true
                newRepo.forks = repo.forks
                newRepo.stargazers = repo.stargazers
                newRepo.isPrivate = repo.isPrivate
                newRepo.watchers = repo.watchers
                newRepo.descriptionString = repo.descriptionString
                newRepo.language = repo.language
                newRepo.urlString = repo.urlString
                newRepo.ownerName = repo.ownerName
            }
        }
        do {
            try github.stack.context.save()
        } catch {
            print("Couldn't save context")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LinkCells", for: indexPath)
        
        cell.textLabel?.text = repo.getType(index: indexPath.row)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        For details other than content
        if indexPath.row != 4 {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "RepositoryDataViewController") as! RepositoryDataViewController
            
            controller.index = indexPath.row
            controller.repo = repo
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
//            For Content
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "ContentListViewController") as! ContentListViewController
            controller.content = repo.content
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
