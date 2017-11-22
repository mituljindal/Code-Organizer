//
//  RepositoryViewController.swift
//  CodeOrganizer
//
//  Created by mitul jindal on 12/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit
import CoreData

class RepositoriesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    var type: RepoType!
    var first = true
    
    @IBOutlet weak var label: UILabel!
    let activityIndicator = UIActivityIndicatorView()
    
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
        
        self.view.backgroundColor = .githubBackground
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = self.view.center
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.view.addSubview(activityIndicator)
        
        if type == nil {
            type = .bookmarked
        }
        
        switch type! {
        case .bookmarked:
            self.navigationItem.title = "Bookmarks"
            label.text = "No Bookmarks"
        case .owned:
            self.navigationItem.title = "Your Repositories"
            label.text = "No Repositories"
        case .starred:
            self.navigationItem.title = "Starred Repositories"
            label.text = "No Starred Repositories"
        }
        
//        Setting fetch requests
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Repository")
        fr.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        fr.predicate = NSPredicate(format: "\(type!) == %@", argumentArray: [true])
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: github.stack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        if type! != .bookmarked {
//            Get repositories
            github.getRepositories(type: type) {
                self.executeSearch()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.hidesWhenStopped = true
        self.executeSearch()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let fc = fetchedResultsController {
            
            if fc.sections![section].numberOfObjects == 0  && first {
                first = false
                self.activityIndicator.startAnimating()
            }
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
                self.activityIndicator.stopAnimating()
                if fc.fetchedObjects?.count == 0 {
                    tableView.isHidden = true
                    label.isHidden = false
                } else {
                    tableView.isHidden = false
                    label.isHidden = true
                    tableView.reloadData()
                }
            } catch let e as NSError {
                print("Error while trying to perform a search: \n\(e)\n\(fetchedResultsController!)")
            }
        }
    }
}

