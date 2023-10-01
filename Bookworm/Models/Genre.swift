//
//  Genre.swift
//  Bookworm
//
//  Created by Nowroz Islam on 30/9/23.
//

import Foundation

enum Genre: String, CaseIterable, Identifiable {
    case fantasy = "Fantasy"
    case horror = "Horror"
    case kids = "Kids"
    case mystery = "Mystery"
    case poetry = "Poetry"
    case romance = "Romance"
    case thriller = "Thriller"
    
    var id: Self {
        self
    }
}
