//
//  DetailsViewController.swift
//  GroupedTableView
//
//  Created by Evgenii Kolgin on 19.05.2022.
//

import Combine
import SDWebImage
import UIKit

class DetailsViewController: UIViewController {
    
    private let filmImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let localizedTitleLabel = CustomLabel(textAlignment: .left, fontSize: 18, fontWeight: .medium)
    private let yearLabel = CustomLabel(textAlignment: .left, fontSize: 18, fontWeight: .medium)
    private let ratingLabel = CustomLabel(textAlignment: .left, fontSize: 20, fontWeight: .medium)
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 16)
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    private let viewModel: DetailsViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    init(_ viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addConstraints()
        setupBindings()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func addConstraints() {
        let stackView = UIStackView(arrangedSubviews: [localizedTitleLabel, yearLabel, ratingLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubviews(filmImageView, stackView, descriptionTextView)
        
        NSLayoutConstraint.activate([
            filmImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            filmImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            filmImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            filmImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            
            stackView.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 10),
            stackView.topAnchor.constraint(equalTo: filmImageView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: filmImageView.bottomAnchor),
            
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionTextView.topAnchor.constraint(equalTo: filmImageView.bottomAnchor, constant: 10),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupBindings() {
        viewModel.$imageUrl
            .sink(receiveValue: { [weak self] urlString in
                if let urlString = urlString {
                    self?.filmImageView.sd_setImage(with: URL(string: urlString), placeholderImage: Constants.Images.noImagePlaceholder)
                }
            })
            .store(in: &cancellables)
        
        viewModel.$localizedTitle
            .sink { [weak self] text in
                self?.localizedTitleLabel.text = text
            }
            .store(in: &cancellables)
        
        viewModel.$year
            .sink { [weak self] text in
                self?.yearLabel.text = text
            }
            .store(in: &cancellables)
        
        viewModel.$rating
            .sink { [weak self] rating in
                guard let rating = rating else { return }
                
                let firstString = NSMutableAttributedString(string: "Рейтинг: ")
                let secondString = NSAttributedString(string: rating.text, attributes: [.foregroundColor: rating.color])
                
                firstString.append(secondString)
                
                self?.ratingLabel.attributedText = firstString
            }
            .store(in: &cancellables)
        
        viewModel.$description
            .sink { [weak self] text in
                self?.descriptionTextView.text = text
            }
            .store(in: &cancellables)
    }
}
