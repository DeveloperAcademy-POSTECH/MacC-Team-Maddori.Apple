//
//  UITabBar+Extension.swift
//  Maddori.Apple
//
//  Created by LeeSungHo on 2022/11/14.
//

import UIKit

extension UITabBar {
    static func clearShadow() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.backgroundWhite
    }
}
