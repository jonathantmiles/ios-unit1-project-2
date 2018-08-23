//
//  VolumeRepresentation.swift
//  BookShelves
//
//  Created by Jonathan T. Miles on 8/22/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import Foundation

struct VolumeRepresentation: Equatable, Codable {
    let id: String?
    struct VolumeInfo: Equatable, Codable {
        let title: String?
        let authors: [String]?
        struct ImageLinks: Equatable, Codable {
            let smallThumbnail: URL?
            let thumbnail: URL?
            let small: URL?
            let medium: URL?
            let large: URL?
            let extraLarge: URL?
        }
        let imageLinks : ImageLinks?
        let description: String?
    }
    let volumeInfo: VolumeInfo?
}


