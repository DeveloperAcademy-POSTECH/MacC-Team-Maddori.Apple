//
//  ImageLiteral.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/14.
//

import UIKit

enum ImageLiterals {
    
    // MARK: - icon
    
    static var icClose: UIImage { .load(systemName: "xmark") }
    static var icBack: UIImage { .load(systemName: "chevron.left") }
    static var icWarning: UIImage { .load(systemName: "exclamationmark.circle.fill") }
    static var icComplete: UIImage { .load(systemName: "checkmark.circle.fill") }
    static var icPin: UIImage { .load(systemName: "pin.circle.fill") }
    static var icBox: UIImage { .load(systemName: "archivebox.circle.fill") }
    static var icRight: UIImage { .load(systemName: "chevron.right") }
    
    // MARK: - image
    
    static var imgCalendar: UIImage { .load(name: "calendar") }
    static var imgKeygoLogo: UIImage { .load(name: "KeyGoIcon") }
    static var imgEmptyCalendar: UIImage { .load(name: "emptyCalendar") }
    static var imgHomeTab: UIImage { .load(name: "Home") }
    static var imgDocsTab: UIImage { .load(name: "Docs") }
    static var imgPersonTab: UIImage { .load(name: "Person") }
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

