//
//  ViewController.swift
//  GroupedTableView
//
//  Created by Evgenii Kolgin on 19.05.2022.
//

import Combine
import UIKit

class FilmListViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(FilmListTableViewCell.self, forCellReuseIdentifier: FilmListTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return tableView
    }()
    
    private let viewModel: FilmListViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    init(_ viewModel: FilmListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
        setupBinding()
        fetchFilms()
    }

    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupBinding() {
        viewModel.$sections
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            .store(in: &cancellables)
    }
    
    private func fetchFilms() {
        viewModel.fetchFilms { [weak self] error in
            self?.presentAlertOnMainThread(title: "Oooops", message: error, buttonTitle: "Ok")
        }
    }
}
// MARK: - UITableViewDataSource

extension FilmListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilmListTableViewCell.identifier, for: indexPath) as? FilmListTableViewCell else { fatalError() }
        let model = viewModel.createFilmCellViewModel(for: indexPath)
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.getTitleForHeader(in: section)
    }
}
// MARK: - UITableViewDelegate

extension FilmListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = viewModel.createdDetailsViewModel(for: indexPath)
        let vc = DetailsViewController(model)
        navigationController?.pushViewController(vc, animated: true)
    }
}
