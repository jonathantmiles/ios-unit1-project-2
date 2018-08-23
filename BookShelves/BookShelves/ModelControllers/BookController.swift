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
    
    // MARK: - POST Volumes to Bookshelf
    
    func addVolumeToShelf(withID bookID: String, toShelfID shelfID: Int, completion: @escaping (Error?) -> Void) {
        
        let url = addVolumeURL(toShelfID: shelfID)
        // let requestURL = URLRequest(url: url)
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: "volumeId", value: bookID)]
        
        let requestURL = URLRequest(url: (components?.url)!)
        
        gbAuthClient.addAuthorization(to: requestURL) { (request, error) in
            if let error = error {
                NSLog("Error fetching Bookshelf from server: \(error)")
                completion(error)
            }
            
            URLSession.shared.dataTask(with: request!, completionHandler: { (data, _, error) in
                if let error = error {
                    NSLog("Error with URLSession re: fetching bookshelf: \(error)")
                    completion(error)
                }
                
                guard let data = data else { return }
                
                do {
                    let decodedData = try JSONDecoder().decode(BookshelfRepresentation.self, from: data)
                    if let safeData = decodedData.items {
                        self.bookshelf = safeData
                    }
                    completion(nil)
                } catch {
                    NSLog("Error decoding fetchBookshelf data: \(error)")
                }
            }).resume()
        }
    }
    
    func removeVolumeToShelf(withID bookID: String, toShelfID shelfID: Int, completion: @escaping (Error?) -> Void) {
        
        let url = addVolumeURL(toShelfID: shelfID)
        // let requestURL = URLRequest(url: url)
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: "volumeId", value: bookID)]
        
        let requestURL = URLRequest(url: (components?.url)!)
        
        gbAuthClient.addAuthorization(to: requestURL) { (request, error) in
            if let error = error {
                NSLog("Error fetching Bookshelf from server: \(error)")
                completion(error)
            }
            
            URLSession.shared.dataTask(with: request!, completionHandler: { (data, _, error) in
                if let error = error {
                    NSLog("Error with URLSession re: fetching bookshelf: \(error)")
                    completion(error)
                }
                
                guard let data = data else { return }
                
                do {
                    let decodedData = try JSONDecoder().decode(BookshelfRepresentation.self, from: data)
                    if let safeData = decodedData.items {
                        self.bookshelf = safeData
                    }
                    completion(nil)
                } catch {
                    NSLog("Error decoding fetchBookshelf data: \(error)")
                }
            }).resume()
        }
    }
    
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
    
    func fetchSingleBookshelf(withID id: Int, completion: @escaping (Error?) -> Void) {
        let url = bookshelfURL(fromID: id)
        let requestURL = URLRequest(url: url)
        gbAuthClient.addAuthorization(to: requestURL) { (request, error) in
            if let error = error {
                NSLog("Error fetching Bookshelf from server: \(error)")
            }
            
            URLSession.shared.dataTask(with: request!, completionHandler: { (data, _, error) in
                if let error = error {
                    NSLog("Error with URLSession re: fetching bookshelf: \(error)")
                    completion(error)
                }
                
                guard let data = data else { return }
                
                do {
                    let decodedData = try JSONDecoder().decode(BookshelfRepresentation.self, from: data)
                    if let safeData = decodedData.items {
                        self.bookshelf = safeData
                    }
                    completion(nil)
                } catch {
                    NSLog("Error decoding fetchBookshelf data: \(error)")
                }
            }).resume()
        }
    }
    
    // MARK: - Books in Bookshelf
    
    /*
    func checkShelvesforVolume(withID id: String) -> [Int] {
        var bookInShelves: [Int] = []
        for i in 0...8 {
            checkShelf(withID: i, forVolumeID: id)
            if testInSingleShelf != nil {
                if testInSingleShelf! {
                    bookInShelves.append(i)
                }
            }
        }
        return bookInShelves
    }
 */
    
    func checkShelf(withID shelfID: Int, forVolumeID bookID: String) -> Bool {
        var isThere = false
        fetchSingleBookshelfTest(withID: shelfID) { (error) in
            if let error = error {
                NSLog("Error fetching bookshelf in checkshelf function: \(error)")
            }
            for book in self.testBookshelf {
                if book.id == bookID {
                    isThere = true
                }
            }
        }
        return isThere
    }
    
    func fetchSingleBookshelfTest(withID id: Int, completion: @escaping (Error?) -> Void) {
        let url = bookshelfURL(fromID: id)
        let requestURL = URLRequest(url: url)
        gbAuthClient.addAuthorization(to: requestURL) { (request, error) in
            if let error = error {
                NSLog("Error fetching Bookshelf from server: \(error)")
            }
            
            URLSession.shared.dataTask(with: request!, completionHandler: { (data, _, error) in
                if let error = error {
                    NSLog("Error with URLSession re: fetching bookshelf: \(error)")
                    completion(error)
                }
                
                guard let data = data else { return }
                
                do {
                    let decodedData = try JSONDecoder().decode(BookshelfRepresentation.self, from: data)
                    if let safeData = decodedData.items {
                        self.testBookshelf = safeData
                    }
                    completion(nil)
                } catch {
                    NSLog("Error decoding fetchBookshelf data: \(error)")
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
                NSLog("Error searching for books with search term \(searchTerm): \(error)")
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
    
    // MARK: - Properties & Neat Functions
    
    func bookshelfURL(fromID id: Int) -> URL {
        var bookshelfURLString = "https://www.googleapis.com/books/v1/mylibrary/bookshelves/"
        bookshelfURLString.append("\(String(id))/volumes")
        return URL(string: bookshelfURLString)!
    }
    
    func addVolumeURL(toShelfID id: Int) -> URL {
        var bookshelfURLString = "https://www.googleapis.com/books/v1/mylibrary/bookshelves/"
        bookshelfURLString.append("\(String(id))/addVolume")
        return URL(string: bookshelfURLString)!
    }
    
    func removeVolumeURL(toShelfID id: Int) -> URL {
        var bookshelfURLString = "https://www.googleapis.com/books/v1/mylibrary/bookshelves/"
        bookshelfURLString.append("\(String(id))/removeVolume")
        return URL(string: bookshelfURLString)!
    }
    
    private let searchURL = URL(string: "https://www.googleapis.com/books/v1/volumes")!
    
    var searchedBooks: [VolumeRepresentation] = []
    var bookshelf: [VolumeRepresentation] = []
    var testBookshelf: [VolumeRepresentation] = []
    var bookshelves: [BookshelfRepresentation] = []
    var testInSingleShelf: Bool?
    
    let gbAuthClient = GoogleBooksAuthorizationClient()
    
}
