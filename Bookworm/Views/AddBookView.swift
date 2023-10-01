//
//  AddBookView.swift
//  Bookworm
//
//  Created by Nowroz Islam on 30/9/23.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var genre: Genre = .fantasy
    @State private var rating: Int = 3
    @State private var review: String = ""
    
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var showingAlert: Bool = false
    
    var trimmedTitle: String {
        title.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var trimmedAuthor: String {
        author.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var trimmedReview: String {
        review.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Book title", text: $title)
                
                TextField("Author name", text: $author)
                
                Picker("Select genre", selection: $genre) {
                    ForEach(Genre.allCases) { genre in
                        Text(genre.rawValue)
                    }
                }
                
                LabeledContent("Rating") {
                    StarRatingView(rating: $rating)
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                }
            }
            .navigationTitle("New Book")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        save()
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func save() {
        guard isValid() else {
            return
        }
        
        let newBook = Book(context: moc)
        newBook.id = UUID()
        newBook.title = trimmedTitle
        newBook.author = trimmedAuthor
        newBook.genre = genre.rawValue
        newBook.rating = Int16(rating)
        newBook.review = trimmedReview
        newBook.date = Date.now
        
        if moc.hasChanges {
            try? moc.save()
        }
        
        dismiss()
    }
    
    func isValid() -> Bool {
        guard trimmedTitle.isEmpty == false else {
            displayAlert(withTitle: "Empty Book Title", withMessage: "The book must have a title.")
            return false
        }
        
        guard trimmedAuthor.isEmpty == false else {
            displayAlert(withTitle: "Empty Author", withMessage: "The author must have a name.")
            return false
        }
        
        return true
    }
    
    func displayAlert(withTitle title: String, withMessage message: String) {
        alertTitle = title
        alertMessage = message
        showingAlert = true
    }
}

#Preview {
    AddBookView()
}
