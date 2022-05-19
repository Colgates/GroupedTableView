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
        
        rating = film.rating?.setRating()
        
        description = film.description
    }
    
    private func setRating() -> Rating {
        guard let filmRating = film.rating else {
            return Rating(text: "No rating yet", color: .label)
        }
        
        switch filmRating {
        case ..<5:
            return Rating(text: "\(filmRating)", color: Constants.Colors.redRating)
        case 5..<7:
            return Rating(text: "\(filmRating)", color: Constants.Colors.greyRating)
        case 7... :
            return Rating(text: "\(filmRating)", color: Constants.Colors.greenRating)
        default:
            return Rating(text: "No rating yet", color: .label)
        }
    }
}
