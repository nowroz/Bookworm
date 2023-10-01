//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Nowroz Islam on 30/9/23.
//

import SwiftUI

@main
struct BookwormApp: App {
    var coreDataStack: CoreDataStack = CoreDataStack()
    
    var body: some Scene {
        WindowGroup {
            BookListView()
                .environment(\.managedObjectContext, coreDataStack.container.viewContext)
        }
    }
}
