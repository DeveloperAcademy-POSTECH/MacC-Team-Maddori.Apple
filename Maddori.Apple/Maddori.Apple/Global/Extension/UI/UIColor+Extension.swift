//
//  UIColor+Extension.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/14.
//

import UIKit

extension UIColor {
    
    // MARK: - background
    
    static var backgroundWhite: UIColor {
        return UIColor(hex: "#FDFDFD")
    }
    
    // MARK: - blue
    
    static var blue100: UIColor {
        return UIColor(hex: "#EAEEF9")
    }
    
    static var blue200: UIColor {
        return UIColor(hex: "#4776FB")
    }
    
    static var blue300: UIColor {
        return UIColor(hex: "#F8F9FD")
    }
    
    // MARK: - yellow
    
    static var yellow100: UIColor {
        return UIColor(hex: "#FFF9DC")
    }
    
    static var yellow200: UIColor {
        return UIColor(hex: "#FBDE47")
    }
    
    static var yellow300: UIColor {
        return UIColor(hex: "#F2CC01")
    }
    
    // MARK: - green
    
    static var green100: UIColor {
        return UIColor(hex: "#2AD000")
    }
    
    // MARK: - red
    
    static var red100: UIColor {
        return UIColor(hex: "#FB4752")
    }
    
    // MARK: - gray
    
    static var gray100: UIColor {
        return UIColor(hex: "#F5F5F6")
    }
    
    static var gray200: UIColor {
        return UIColor(hex: "#E9E9E9")
    }
    
    static var gray300: UIColor {
        return UIColor(hex: "#E6E6E6")
    }
    
    static var gray400: UIColor {
        return UIColor(hex: "#979797")
    }
    
    static var gray500: UIColor {
        return UIColor(hex: "#888888")
    }
    
    static var gray600: UIColor {
        return UIColor(hex: "#4B4B4B")
    }
    
    static var gray700: UIColor {
        return UIColor(hex: "#CBCBCB")
    }
    
    // MARK: - black
    
    static var black100: UIColor {
        return UIColor(hex: "#222222")
    }
    
    // MARK: - white
    
    static var white100: UIColor {
        return UIColor(hex: "#FFFFFF")
    }
    
    static var white200: UIColor {
        return UIColor(hex: "#FDFDFD")
    }
    
    static var white300: UIColor {
        return UIColor(hex: "#FAFAFA")
    }
    
    // MARK: - gradientGray
    
    static var gradientGrayTop: UIColor {
        return UIColor(hex: "#6B737E")
    }
    
    static var gradientGrayBottom: UIColor {
        return UIColor(hex: "#79808A")
    }
    
    // MARK: - gradientBlue100
    
    static var gradientBlue100Top: UIColor {
        return UIColor(hex: "#7598FC")
    }
    
    static var gradientBlue100Bottom: UIColor {
        return UIColor(hex: "#8AA7FA")
    }
    
    // MARK: - gradientBlue
    
    static var gradientBlueTop: UIColor {
        return UIColor(hex: "#4776FB")
    }
    
    static var gradientBlueBottom: UIColor {
        return UIColor(hex: "#648BF9")
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
