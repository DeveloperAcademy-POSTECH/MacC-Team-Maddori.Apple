//
//  UIFont+Extension.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/14.
//

import UIKit

enum FontName: String {
    case regular = "AppleSDGothicNeo-Regular"
    case medium = "AppleSDGothicNeo-Medium"
    case semibold = "AppleSDGothicNeo-SemiBold"
    case bold = "AppleSDGothicNeo-Bold"
}

extension UIFont {
    static func font(_ style: FontName, ofSize size: CGFloat) -> UIFont {
        return UIFont(name: style.rawValue, size: size)!
    }
    
    static var title: UIFont {
        return font(.bold, ofSize: 28)
    }
    
    static var title2: UIFont {
         return font(.bold, ofSize: 24)
     }

    static var main: UIFont {
        return font(.bold, ofSize: 18)
    }
    
    static var label1: UIFont {
        return font(.semibold, ofSize: 18)
    }
    
    static var label2: UIFont {
        return font(.semibold, ofSize: 16)
    }
    
    static var label3: UIFont {
        return font(.bold, ofSize: 16)
    }
    
    static var body1: UIFont {
        return font(.regular, ofSize: 16)
    }
    
    static var body2: UIFont {
        return font(.regular, ofSize: 14)
    }
    
    static var body3: UIFont {
        return font(.medium, ofSize: 16)
    }
    
    static var body4: UIFont {
        return font(.regular, ofSize: 14)
    }
    
    static var caption1: UIFont {
        return font(.regular, ofSize: 15)
    }
    
    static var caption2: UIFont {
        return font(.semibold, ofSize: 12)
    }
    
    static var caption3: UIFont {
        return font(.medium, ofSize: 12)
    }
    
    static var toast: UIFont {
        return font(.semibold, ofSize: 14)
    }
}
