//
//  BookshelvesRepresentation.swift
//  BookShelves
//
//  Created by Jonathan T. Miles on 8/22/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import Foundation

struct BookshelvesRepresentation: Equatable, Codable {
    let items: [BookshelfRepresentation]?
}
