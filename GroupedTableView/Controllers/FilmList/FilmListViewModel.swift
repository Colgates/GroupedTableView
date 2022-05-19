//
//  FilmListViewModel.swift
//  GroupedTableView
//
//  Created by Evgenii Kolgin on 19.05.2022.
//

import Foundation

class FilmListViewModel {
 
    struct Section {
      let year: Int
      let films: [Film]
    }
    
    @Published var sections: [Section] = []
    
    private let networkManager: Networking
    
    init(networkManager: Networking) {
        self.networkManager = networkManager
    }
    
    func getNumberOfSections() -> Int {
        sections.count
    }
    
    func getNumberOfRows(in section: Int) -> Int {
        sections[section].films.count
    }
    
    func getTitleForHeader(in section: Int) -> String {
        String(sections[section].year)
    }
    
    func createFilmCellViewModel(for indexPath: IndexPath) -> FilmCellViewModel {
        let section = sections[indexPath.section]
        let film = section.films[indexPath.row]
        return FilmCellViewModel(film: film)
    }
    
    func createdDetailsViewModel(for indexPath: IndexPath) -> DetailsViewModel {
        let section = sections[indexPath.section]
        let film = section.films[indexPath.row]
        return DetailsViewModel(film: film)
    }
    
    func fetchFilms(completeWithErrors: @escaping (String) -> Void) {
        Task {
            let result = try await networkManager.fetchFilms()

            switch result {
            case .success(let films):
                let groupedDictionary = Dictionary(grouping: films, by: { $0.year })
        
                let keys = groupedDictionary.keys.sorted()
        
                sections = keys.map { Section(year: $0, films: groupedDictionary[$0]!.sorted(by: { $0.rating ?? 0 > $1.rating ?? 0 })) }
                
            case .failure(let error):
                completeWithErrors(error.localizedDescription)
            }
        }
    }
}
