//
//  ProfileViewController.swift
//  GitHub-OnTheGo
//
//  Created by mitul jindal on 16/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextView: CustomUITextView!
    @IBOutlet weak var usernameTextView: CustomUITextView!
    @IBOutlet weak var emailIDTextView: CustomUITextView!
    @IBOutlet weak var tableView: UITableView!
    
    var fetchedResultsController : NSFetchedResultsController<NSFetchRequestResult>? {
        didSet {
            // Whenever the frc changes, we execute the search and reload the table
            fetchedResultsController?.delegate = self
            executeSearch()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = 62.5
        profileImageView.layer.masksToBounds = true
        profileImageView.image = UIImage(named: "no user icon")
        
        github.getUserInfo {
            self.executeSearch()
        }
        
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fr.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: appDelegate.stack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        self.navigationController?.navigationBar.topItem?.title = "GitHub-OnTheGo"
        
        tableView.isScrollEnabled = false
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: "Are you sure?", preferredStyle: .alert)
        let no = UIAlertAction(title: "No", style: .default, handler: nil)
        let yes = UIAlertAction(title: "Yes", style: .default) { action in
            
            self.github.logout {
                let controller = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                
                self.present(controller, animated: false, completion: nil)
            }
        }
        
        alert.addAction(no)
        alert.addAction(yes)
        self.present(alert, animated: true, completion: nil)
    }
    
    func setViews() {
        let indexPath = IndexPath(row: 0, section: 0)
        
        if fetchedResultsController?.fetchedObjects?.count == 0 {
            return
        }
        
        let user = fetchedResultsController!.object(at: indexPath) as! User
        
        nameTextView.text = user.name!
        usernameTextView.text = user.username!
        emailIDTextView.text = user.email ?? "Email not available"
        
        if let url = user.imageURL {
            profileImageView.downloadImageFrom(link: url)
        } else {
            profileImageView.image = UIImage(named: "no user icon")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "Owned"
        } else {
            cell.textLabel?.text = "Starred"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "RepositoriesListViewController") as! RepositoriesListViewController
        if indexPath.row == 0 {
            controller.type = .owned
        } else {
            controller.type = .starred
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func executeSearch() {
        if let fc = fetchedResultsController {
            do {
                try fc.performFetch()
                setViews()
            } catch let e as NSError {
                print("Error while trying to perform a search: \n\(e)\n\(fetchedResultsController!)")
            }
        }
    }
}
