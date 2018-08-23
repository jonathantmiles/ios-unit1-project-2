//
//  BookController.swift
//  BookShelves
//
//  Created by Jonathan T. Miles on 8/22/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import Foundation

class BookController {
    
    // MARK: -
    
    /*
     addVolumeToBookshelf(volume: Volume<CoreDataObject>, toBookshelf: Bookshelf<CoreDataObject>) {
        post
     
     post() {
     url: https://www.googleapis.com/books/v1/mylibrary/bookshelves/shelf/addVolume
     replace "shelf" with Int of bookshelf id
     
    */
    
    // MARK: - Bookshelf Controller API Integration
    
    func fetchBookshelves(completion: @escaping (Error?) -> Void) {
        
        let requestURL = URLRequest(url: URL(string: "https://www.googleapis.com/books/v1/mylibrary/bookshelves")!)
        
        gbAuthClient.addAuthorization(to: requestURL) { (request, error) in
            if let error = error {
                NSLog("Error fetching Bookshelves from server: \(error)")
            }
            
            URLSession.shared.dataTask(with: request!, completionHandler: { (data, _, error) in
                if let error = error {
                    NSLog("Error with URLSession re: fetching bookshelves: \(error)")
                    completion(error)
                }
                
                guard let data = data else { return }
                
                do {
                    let decodedData = try JSONDecoder().decode(BookshelvesRepresentation.self, from: data)
                    if let safeData = decodedData.items {
                        self.bookshelves = safeData
                    }
                    completion(nil)
                } catch {
                    NSLog("Error decoding fetchBookshelves data: \(error)")
                }
            }).resume()
        }

    }
    
    
    // MARK: - Search Functionality
    
    func searchForBook(with searchTerm: String, completion: @escaping (Error?) -> Void) {
        
        var components = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        
        components?.queryItems = [URLQueryItem(name: "q", value: searchTerm)] // queryParameters.map({URLQueryItem(name: $0.key, value: $0.value)})
        
        guard let requestURL = components?.url else {
            completion(NSError())
            return
        }
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            
            if let error = error {
                NSLog("Error searching for movie with search term \(searchTerm): \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(NSError())
                return
            }
            
            do {
                let decodedSearch = try JSONDecoder().decode(BookshelfRepresentation.self, from: data).items
                self.searchedBooks = decodedSearch!
                completion(nil)
            } catch {
                NSLog("Error decoding JSON data: \(error)")
                completion(error)
            }
            }.resume()
    }
    
    // MARK: - Properties
    
    private let searchURL = URL(string: "https://www.googleapis.com/books/v1/volumes")!
    
    var searchedBooks: [VolumeRepresentation] = []
    var bookshelves: [BookshelfRepresentation] = []
    
    let gbAuthClient = GoogleBooksAuthorizationClient()
    
}
