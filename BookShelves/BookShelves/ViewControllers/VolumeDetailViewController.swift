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
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
                        DispatchQueue.main.async {
                            let image = self.imageHelper.convertURLToImage(fromStruct: imageLinks)
                            self.coverImageView.image = image
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Properties
    
    var volume: VolumeRepresentation? {
        didSet {
            updateViews()
        }
    }
    var bookController: BookController?
    let imageHelper = ImageHelper()
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var authorsListLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var changeBookshelfOutlet: UIButton!
    
}
