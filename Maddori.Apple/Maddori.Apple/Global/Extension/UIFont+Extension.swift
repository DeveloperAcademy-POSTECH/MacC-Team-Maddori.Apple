//
//  UIFont+Extension.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/14.
//

import UIKit

enum FontName: String {
    case regular = "AppleSDGothicNeo-Regular"
    case thin = "AppleSDGothicNeo-Thin"
    case ultraLight = "AppleSDGothicNeo-UltraLight"
    case light = "AppleSDGothicNeo-Light"
    case medium = "AppleSDGothicNeo-Medium"
    case semibold = "AppleSDGothicNeo-SemiBold"
    case bold = "AppleSDGothicNeo-Bold"
}

extension UIFont {
    static func font(_ style: FontName, ofSize size: CGFloat) -> UIFont {
        return UIFont(name: style.rawValue, size: size)!
    }
}
