//
//  BookDetailsView.swift
//  Bookworm
//
//  Created by Nowroz Islam on 30/9/23.
//

import SwiftUI

struct BookDetailsView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) private var dismiss
    
    let book: Book
    
    @State private var showingDeleteAlert: Bool = false
    
    var formattedReviewDate: String {
        book.date?.formatted(date: .abbreviated, time: .omitted) ?? Date.now.formatted(date: .abbreviated, time: .omitted)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack(alignment: .bottomLeading) {
                    ZStack(alignment: .topTrailing) {
                        Image(book.genre ?? "Fantasy")
                        
                        Text(book.genre ?? "Fantasy")
                            .padding()
                            .font(.callout)
                            .foregroundStyle(.white)
                            .background(.black.opacity(0.8))
                            .clipShape(Capsule())
                            .padding()
                    }
                    
                    LinearGradient(
                        colors: [
                            .clear,
                            .black
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    
                    Text(book.title ?? "Unknown Title")
                        .font(.title.weight(.semibold))
                        .foregroundStyle(.white)
                        .padding()
                }
                
                Text(book.author ?? "Unknown Author")
                    .font(.title.weight(.semibold))
                    .foregroundStyle(.secondary)
                    .padding(5)
                
                StarRatingView(rating: .constant(Int(book.rating)))
                    .font(.title)
                
                LabeledContent("Date reviewed") {
                    Text(formattedReviewDate)
                }
                .padding(.horizontal)
                .padding(.top)
                
                Divider()
                    .padding(.horizontal)
                
                Text(book.review ?? "")
                    .padding()
            }
        }
        .navigationTitle("Book Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete book", systemImage: "trash")
            }
        }
        .alert("Delete Book?", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Confirm", role: .destructive, action: delete)
        } message: {
            Text("Are you sure?")
        }
    }
    
    func delete() {
        moc.delete(book)
        
        if moc.hasChanges {
            try? moc.save()
        }
        
        dismiss()
    }
}

#Preview {
    let book = Book(context: CoreDataStack().container.viewContext)
    book.id = UUID()
    book.title = "Harry Potter & The Philospher's Stone"
    book.author = "J. K. Rowling"
    book.genre = Genre.fantasy.rawValue
    book.rating = 5
    book.review = "Must read book. The very first series of 7 books of awesomeness."
    
    return NavigationStack {
        BookDetailsView(book: book)
    }
}
