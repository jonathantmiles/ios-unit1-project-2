//
//  Array+AuthorsDisplay.swift
//  BookShelves
//
//  Created by Jonathan T. Miles on 8/22/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import Foundation

extension Array {
    func displayAuthorsAsString(authors: [String]) -> String {
        var displayAuthors: String = ""
        switch authors.count {
        case 1:
            displayAuthors = authors.first!
        case 2:
            displayAuthors = "\(authors[0]) and \(authors[1])"
        case 3:
            displayAuthors = "\(authors[0]), \(authors[1]), and \(authors[2])"
        case 4:
            displayAuthors = "\(authors[0]), \(authors[1]), et al."
        case 5:
            displayAuthors = "\(authors[0]), \(authors[1]), et al."
        case 6:
            displayAuthors = "\(authors[0]), \(authors[1]), et al."
        case 7:
            displayAuthors = "\(authors[0]), \(authors[1]), et al."
        default:
            displayAuthors = authors.first!
        }
        return displayAuthors
    }
}
