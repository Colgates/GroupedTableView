//
//  UIView + Extensions.swift
//  GroupedTableView
//
//  Created by Evgenii Kolgin on 19.05.2022.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
