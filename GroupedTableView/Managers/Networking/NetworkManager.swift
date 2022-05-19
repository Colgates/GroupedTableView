//
//  NetworkManager.swift
//  GroupedTableView
//
//  Created by Evgenii Kolgin on 19.05.2022.
//

import Foundation

protocol Networking {
    func fetchFilms() async throws -> Result<[Film], Error>
}

class NetworkManager: Networking {
    
    func fetchFilms() async -> Result<[Film], Error> {
        guard let url = URL(string: "https://s3-eu-west-1.amazonaws.com/sequeniatesttask/films.json") else { return .failure(NetworkError.invalidUrl )}

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(Response.self, from: data)
            return .success(decodedData.films)
        } catch {
            return .failure(error)
        }
    }
}
