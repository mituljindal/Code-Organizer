//
//  RepositoryViewController.swift
//  GitHub-OnTheGo
//
//  Created by mitul jindal on 12/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit
import CoreData

class RepositoriesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var fetchedResultsController : NSFetchedResultsController<NSFetchRequestResult>? {
        didSet {
            // Whenever the frc changes, we execute the search and reload the table
            fetchedResultsController?.delegate = self
            executeSearch()
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = "GitHub-OnTheGo"
        
//        Setting fetch requests
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Repository")
        fr.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: super.appDelegate.stack.context, sectionNameKeyPath: nil, cacheName: nil)
        
//        Get repositories
        github.getRepositories() {
            self.executeSearch()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let fc = fetchedResultsController {
            return fc.sections![section].numberOfObjects
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "RepositoryView") as! RepositoryViewController
        
        controller.repo = fetchedResultsController!.object(at: indexPath) as! Repository
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let repo = fetchedResultsController!.object(at: indexPath) as! Repository
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath)
        
        cell.textLabel?.text = repo.name
        if let desc = repo.descriptionString {
            cell.detailTextLabel?.text = desc
        } else {
            cell.detailTextLabel?.text = ""
        }
        return cell
    }
    
    func executeSearch() {
        if let fc = fetchedResultsController {
            do {
                try fc.performFetch()
                tableView.reloadData()
            } catch let e as NSError {
                print("Error while trying to perform a search: \n\(e)\n\(fetchedResultsController!)")
            }
        }
    }
}

