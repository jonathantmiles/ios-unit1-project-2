//
//  CoreDataStack.swift
//  BookShelves
//
//  Created by Jonathan T. Miles on 8/22/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BookShelves")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                fatalError("Failed to load persistent store: \(error)")
            }
        })
        
        return container
    } ()
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
}
