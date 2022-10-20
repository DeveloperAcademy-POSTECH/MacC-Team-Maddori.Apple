//
//  ImageLiteral.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/14.
//

import UIKit

enum ImageLiterals {
    
    // MARK: - icon
    
    static var icClose: UIImage { .load(systemName: "xmark")}
    
    // MARK: - image
    
    static var imgCalendar: UIImage { .load(name: "calendar") }
}

extension UIImage {
    static func load(name: String) -> UIImage {
        guard let image = UIImage(named: name, in: nil, compatibleWith: nil) else {
            return UIImage()
        }
        image.accessibilityIdentifier = name
        return image
    }
    
    static func load(systemName: String) -> UIImage {
        guard let image = UIImage(systemName: systemName) else {
            return UIImage()
        }
        image.accessibilityIdentifier = systemName
        return image
    }
}

