//
//  BookshelfTableViewController.swift
//  BookShelves
//
//  Created by Jonathan T. Miles on 8/21/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import UIKit

class BookshelfTableViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookController.bookshelves.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookshelfCell", for: indexPath)

        let bookshelf = bookController.bookshelves[indexPath.row]
        
        cell.textLabel?.text = bookshelf.title
        cell.detailTextLabel?.text = "\(bookshelf.volumeCount ?? 0)"

        return cell
    }
    
    private func updateViews() {
        bookController.fetchBookshelves { (error) in
            if let error = error {
                NSLog("error fetching in bookshelf viewWillAppear: \(error)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowBookshelfDetail" {
            let destVC = segue.destination as! BookshelfCollectionViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destVC.bookshelfID = bookController.bookshelves[indexPath.row].id
            }
            destVC.bookController = bookController
        }
    }
    
    // MARK: - Properties
    
    let bookController = BookController()

}
