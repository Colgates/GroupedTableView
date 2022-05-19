//
//  Models.swift
//  GroupedTableView
//
//  Created by Evgenii Kolgin on 19.05.2022.
//

import Foundation

struct Response: Decodable {
    let films: [Film]
}

struct Film: Decodable {
    let id: Int
    let localizedName: String
    let name: String
    let year: Int
    let rating: Float?
    let imageUrl: String?
    let description: String?
//    let genres: [String]?
}
