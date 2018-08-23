//
//  BookshelfRepresentation.swift
//  BookShelves
//
//  Created by Jonathan T. Miles on 8/22/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import Foundation

struct BookshelfRepresentation: Equatable, Codable {
    let title: String?
    let id: Int?
    let items: [VolumeRepresentation]?
    let volumeCount: Int?
    let totalItems: Int?
}
