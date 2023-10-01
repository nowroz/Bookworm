//
//  StarRatingView.swift
//  Bookworm
//
//  Created by Nowroz Islam on 30/9/23.
//

import SwiftUI

struct StarRatingView: View {
    @Binding var rating: Int
    
    var body: some View {
        HStack {
            ForEach(1..<6) { num in
                Image(systemName: "star.fill")
                    .foregroundStyle(color(for: num))
                    .onTapGesture {
                        withAnimation {
                            rating = num
                        }
                    }
            }
        }
    }
    
    func color(for num: Int) -> Color {
        if num <= rating {
            Color.yellow
        } else {
            Color.gray
        }
    }
}

#Preview {
    StarRatingView(rating: .constant(3))
}
