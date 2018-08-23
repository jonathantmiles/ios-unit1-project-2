//
//  ChangeBookshelfViewController.swift
//  BookShelves
//
//  Created by Jonathan T. Miles on 8/23/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import UIKit

class ChangeBookshelfViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateViews() {
        DispatchQueue.main.async {
            if let fromSearch = self.fromSearch {
                self.favoritesOutlet.setTitle("Add to Favorites", for: .normal)
                self.helpfulTextLabel.text = (fromSearch ? "Add to bookshelf:" : "Move to a new bookshelf")
                self.toReadOutlet.setTitle((fromSearch ? "Add to To Read" : "Move to To Read" ), for: .normal)
                self.readingNowOutlet.setTitle((fromSearch ? "Add to Reading Now" : "Move to Reading Now" ), for: .normal)
                self.readOutlet.setTitle((fromSearch ? "Add to Have Read" : "Move from Have Read" ), for: .normal)
            }
        }
    }
    
    // MARK: - Buttons
    
    @IBAction func favoriteToggle(_ sender: Any) {
    }
    @IBAction func sendToRead(_ sender: Any) {
    }
    @IBAction func sendReadingNow(_ sender: Any) {
    }
    @IBAction func sendRead(_ sender: Any) {
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var favoritesOutlet: UIButton!
    @IBOutlet weak var helpfulTextLabel: UILabel!
    @IBOutlet weak var toReadOutlet: UIButton!
    @IBOutlet weak var readingNowOutlet: UIButton!
    @IBOutlet weak var readOutlet: UIButton!
    
    var bookController: BookController?
    var volume: VolumeRepresentation?
    var fromSearch: Bool?
}
