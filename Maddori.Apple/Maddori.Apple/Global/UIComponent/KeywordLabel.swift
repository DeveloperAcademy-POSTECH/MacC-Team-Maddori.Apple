//
//  KeywordLabel.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/10/18.
//

import UIKit

enum KeywordType: CaseIterable {
    case defaultKeyword
    case subKeyword
    case disabledKeyword
    case previewKeyword
    
    var maskedCorners: CACornerMask {
        switch self {
        case .previewKeyword:
            return [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
        default:
            return [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
    }
    
    var labelColor: [UIColor] {
        switch self {
        case .defaultKeyword:
            return [.gradientBlueTop, .gradientBlueBottom]
        default:
            return [.white100, .white100]
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .defaultKeyword:
            return .white100
        case .disabledKeyword:
            return .gray300
        default:
            return .gray600
        }
    }
    
    var shadowOpacity: Float {
        switch self {
        case .previewKeyword:
            return 0.13
        default:
            return 0.25
        }
    }
    
    var shadowRadius: CGFloat {
        switch self {
        case .disabledKeyword:
            return 1
        default:
            return 4
        }
    }
    
    var shadowOffset: CGSize {
        switch self {
        case .previewKeyword:
            return CGSize(width: 0, height: 1)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
}
// TODO: shadow를 struct로 빼서 하는게 나을까요?

class KeywordLabel: UILabel {

    private let horizontalInset: CGFloat = 18.0
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: (horizontalInset * 2) + size.width,
                      height: size.height)
    }
}
