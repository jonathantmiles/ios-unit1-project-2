//
//  VolumeDetailViewController.swift
//  BookShelves
//
//  Created by Jonathan T. Miles on 8/21/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import UIKit

class VolumeDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeBookshelf(_ sender: Any) {
        self.performSegue(withIdentifier: "ChooseBookShelf", sender: nil)
        
    }
    
    func updateViews() {
        DispatchQueue.main.async {
            if let volume = self.volume {
                if let volumeInfo = volume.volumeInfo {
                    if let title = volumeInfo.title {
                        self.title = title
                    }
                    if let authors = volumeInfo.authors {
                            self.authorsListLabel.text = authors.displayAuthorsAsString(authors: authors)
                    }
                    if let description = volumeInfo.description {
                            self.descriptionTextView.text = description
                    }
                    if let imageLinks = volumeInfo.imageLinks {
                            let image = self.imageHelper.convertURLToImage(fromStruct: imageLinks)
                            self.coverImageView.image = image
                    }
                }
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChooseBookShelf" {
            let destVC = segue.destination as! ChangeBookshelfViewController
            destVC.bookController = bookController
            destVC.volume = volume
            destVC.fromSearch = fromSearch
        }
    }
    
    // MARK: - Properties
    
    var volume: VolumeRepresentation?
    var bookController: BookController?
    var shelfID: Int?
    let imageHelper = ImageHelper()
    
    var fromSearch: Bool?
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var authorsListLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var changeBookshelfOutlet: UIButton!
    
}
