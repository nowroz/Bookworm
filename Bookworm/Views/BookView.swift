//
//  BookView.swift
//  Bookworm
//
//  Created by Nowroz Islam on 30/9/23.
//

import SwiftUI

struct BookView: View {
    let book: Book
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(book.title ?? "Unknown Title")
                    .font(.headline)
                
                Text(book.author ?? "Unknown Author")
                    .font(.subheadline)
            }
            
            Spacer()
            
            HStack(spacing: 3) {
                Text("\(Int(book.rating))")
                
                Image(systemName: "star.fill")
                    .foregroundStyle(Int(book.rating) == 1 ? .red : .yellow)
            }
        }
    }
}

#Preview {
    let book = Book(context: CoreDataStack().container.viewContext)
    book.id = UUID()
    book.title = "Harry Potter & The Philospher's Stone"
    book.genre = Genre.fantasy.rawValue
    book.rating = 5
    book.review = ""
    
    return BookView(book: book)
}
