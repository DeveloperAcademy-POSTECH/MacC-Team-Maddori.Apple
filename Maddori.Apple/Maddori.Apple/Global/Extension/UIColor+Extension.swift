//
//  UIColor+Extension.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/14.
//

import UIKit

extension UIColor {
    
    // MARK: - background
    
    static var backgrounWhite: UIColor {
        return UIColor(hex: "#FDFDFD")
    }
    
    // MARK: - blue
    
    static var mainBlue: UIColor {
        return UIColor(hex: "#4776FB")
    }
    
    // MARK: - gray
    
    static var disableGray: UIColor {
        return UIColor(hex: "#E9E9E9")
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
    }
}
