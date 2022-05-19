//
//  FilmListTableViewCell.swift
//  GroupedTableView
//
//  Created by Evgenii Kolgin on 19.05.2022.
//

import UIKit

class FilmListTableViewCell: UITableViewCell {
    
    static let identifier = "FilmListTableViewCell"
    
    private let titleLabel = CustomLabel(textAlignment: .left, fontSize: 18, fontWeight: .bold)
    private let localizedTitleLabel = CustomLabel(textAlignment: .left, fontSize: 16, fontWeight: .medium)
    private let ratingLabel = CustomLabel(textAlignment: .center, fontSize: 24, fontWeight: .bold)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        contentView.addSubviews(titleLabel, localizedTitleLabel, ratingLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            
            localizedTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            localizedTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            localizedTitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            localizedTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            ratingLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            ratingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            ratingLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
        ])
    }
    
    func configure(with viewModel: FilmCellViewModel) {
        titleLabel.text = viewModel.title
        localizedTitleLabel.text = viewModel.localizedTitle
        ratingLabel.text = viewModel.rating.text
        ratingLabel.textColor = viewModel.rating.color
    }
}

class FilmCellViewModel {
    
    private let film: Film
    
    init(film: Film) {
        self.film = film
    }
    
    var title: String {
        film.name
    }
    
    var localizedTitle: String {
        film.localizedName
    }
    
    var rating: Rating {
        guard let filmRating = film.rating else { return Rating(text: "No rating yet", color: .label)}
        return filmRating.setRating()
    }
}
