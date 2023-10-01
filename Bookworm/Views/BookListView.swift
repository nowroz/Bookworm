//
//  ContentView.swift
//  Bookworm
//
//  Created by Nowroz Islam on 30/9/23.
//

import SwiftUI

struct BookListView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddBookSheet: Bool = false
    
    
    var body: some View {
        NavigationStack {
            List {
                Section("Total Reviews: \(books.count)"){
                    ForEach(books) { book in
                        NavigationLink {
                            BookDetailsView(book: book)
                        } label: {
                           BookView(book: book)
                        }
                    }
                    .onDelete(perform: delete)
                }
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddBookSheet = true
                    } label: {
                        Label("Add book", systemImage: "plus")
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddBookSheet) {
                AddBookView()
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
            let book = books[index]
            
            moc.delete(book)
            
            if moc.hasChanges {
                try? moc.save()
            }
        }
    }
}

#Preview {
    BookListView()
        .environment(\.managedObjectContext, CoreDataStack().container.viewContext)
}
