//
//  Float + Extensions.swift
//  GroupedTableView
//
//  Created by Evgenii Kolgin on 19.05.2022.
//

import Foundation

extension Float {
    func setRating() -> Rating {
        switch self {
        case ..<5:
            return Rating(text: "\(self)", color: Constants.Colors.redRating)
        case 5..<7:
            return Rating(text: "\(self)", color: Constants.Colors.greyRating)
        case 7... :
            return Rating(text: "\(self)", color: Constants.Colors.greenRating)
        default:
            return Rating(text: "No rating yet", color: .label)
        }
    }
}
