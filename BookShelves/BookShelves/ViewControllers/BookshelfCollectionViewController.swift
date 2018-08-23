//
//  BookshelfCollectionViewController.swift
//  BookShelves
//
//  Created by Jonathan T. Miles on 8/21/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "VolumeItem"

class BookshelfCollectionViewController: UICollectionViewController {

    override func viewWillAppear(_ animated: Bool) {
        updateViews()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowVolumeDetail" {
            let destVC = segue.destination as! VolumeDetailViewController
            destVC.bookController = bookController
            if let indexPath = collectionView?.indexPathsForSelectedItems?.first {
                destVC.volume = bookController?.bookshelf[indexPath.item]
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return (bookController?.bookshelf.count)!
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VolumeItem", for: indexPath) as! VolumeCollectionViewCell
    
        cell.bookController = bookController
        cell.volumeRep = bookController?.bookshelf[indexPath.item]
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    func updateViews() {
        bookController?.fetchSingleBookshelf(withID: bookshelfID!, completion: { (error) in
            if let error = error {
                NSLog("Error fetching in Collection View: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
            // self.title = bookController?
        })
    }
    
    // MARK: - Properties
    
    var bookController: BookController?
    var bookshelfID: Int?

}
