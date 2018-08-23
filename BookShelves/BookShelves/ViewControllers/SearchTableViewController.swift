//
//  SearchTableViewController.swift
//  BookShelves
//
//  Created by Jonathan T. Miles on 8/21/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookController.searchedBooks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
        guard let authors = bookController.searchedBooks[indexPath.row].volumeInfo?.authors else { return cell }
        
        cell.textLabel?.text = bookController.searchedBooks[indexPath.row].volumeInfo?.title
        cell.detailTextLabel?.text = authors.displayAuthorsAsString(authors: authors)
        
        return cell
    }
    
    // MARK: - Search
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        bookController.searchForBook(with: searchTerm.lowercased()) { (error) in
            
            guard error == nil else { return }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchDetailSegue" {
            let destVC = segue.destination as! VolumeDetailViewController
            destVC.bookController = bookController
            if let indexPath = tableView.indexPathForSelectedRow {
                destVC.volume = bookController.searchedBooks[indexPath.row]
            }
        }
    }
    
    // MARK: - Properties
    
    let bookController = BookController()

    @IBOutlet weak var searchBar: UISearchBar!
}
