//
//  VolumeCollectionViewCell.swift
//  BookShelves
//
//  Created by Jonathan T. Miles on 8/23/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import UIKit

class VolumeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    var bookController: BookController?
    var volumeRep: VolumeRepresentation? {
        didSet {
            DispatchQueue.main.async {
                if let volume = self.volumeRep {
                    if let volumeInfo = volume.volumeInfo {
                        if let title = volumeInfo.title {
                            self.titleLabel.text = title
                        }
                        if let authors = volumeInfo.authors {
                            self.authorLabel.text = authors.displayAuthorsAsString(authors: authors)
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
    }
    let imageHelper = ImageHelper()
}
