//
//  CoreDataStack.swift
//  Bookworm
//
//  Created by Nowroz Islam on 30/9/23.
//

import CoreData
import Foundation

class CoreDataStack {
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Bookworm")
        
        container.loadPersistentStores { description, error in
            if let error {
                fatalError("Unable to load persistent stores: \(error.localizedDescription)")
            }
        }
        
        return container
    }()
}
