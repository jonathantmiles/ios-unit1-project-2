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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Properties
    
    let bookController = BookController()

}
