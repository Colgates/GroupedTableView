//
//  DetailsViewModel.swift
//  GroupedTableView
//
//  Created by Evgenii Kolgin on 19.05.2022.
//

import Foundation

class DetailsViewModel {
    
    private var film: Film
    
    init(film: Film) {
        self.film = film
        updateUI()
    }
    
    @Published var imageUrl: String?
    @Published var localizedTitle: String?
    @Published var year: String?
    @Published var rating: Rating?
    @Published var description: String?
    
    private func updateUI() {
        imageUrl = film.imageUrl ?? ""
        localizedTitle = film.localizedName
        year = "Год: \(film.year)"
        
        if let filmRating = film.rating {
            rating = filmRating.setRating()
        } else {
            rating = Rating(text: "-", color: .label)
        }
        
        description = film.description
    }
}
