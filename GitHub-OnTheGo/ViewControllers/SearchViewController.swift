//
//  SearchViewController.swift
//  GitHub-OnTheGo
//
//  Created by mitul jindal on 15/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {
    
    
    var searchBar: UISearchBar!
    let searchClient = GitHubSearchClient.shared
    var languageBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        languageBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 100, height: 20))
        tableView.tableHeaderView?.addSubview(languageBar)
        tableView.tableHeaderView?.isHidden = false
        
        setupSearchBar()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchClient.repos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCells", for: indexPath)
        
        cell.textLabel?.text = searchClient.repos[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "RepositoryView") as! RepositoryViewController
        
        controller.repo = searchClient.repos[indexPath.row]
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func setupSearchBar() {
        
        let width = self.view.frame.width
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: width, height: 20))
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        searchBar.placeholder = "Search Repositories"
        searchBar.keyboardType = .asciiCapable
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let barButton = UIBarButtonItem(customView: searchBar)
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = barButton
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = nil
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.text = searchText.replacingOccurrences(of: " ", with: "")
        
        if searchText == "" || searchText == " " {
            searchClient.clearRepos() {
                self.tableView.reloadData()
            }
        } else {
            searchClient.searchRepositories(query: searchBar.text!) {
                self.tableView.reloadData()
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
