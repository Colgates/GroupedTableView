//
//  UIColor + Extensions.swift
//  GroupedTableView
//
//  Created by Evgenii Kolgin on 28.05.2022.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        
            let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int: UInt64 = 0
            Scanner(string: hex).scanHexInt64(&int)
            let r, g, b, a: UInt64
            switch hex.count {
            case 3: // RGB (12-bit)
                (r, g, b, a) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17, 255)
            case 6: // RGB (24-bit)
                (r, g, b, a) = (int >> 16, int >> 8 & 0xFF, int & 0xFF, 255)
            case 8: // ARGB (32-bit)
                (r, g, b, a) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF, int >> 24)
            default:
                (r, g, b, a) = (1, 1, 1, 1)
            }

        self.init(red: Double(r) / 255.0,
                  green: Double(g) / 255.0,
                  blue: Double(b) / 255.0,
                  alpha: Double(a))
    }
}
