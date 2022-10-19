//
//  KeywordLabel.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/10/18.
//

import UIKit

enum KeywordType {
    case defaultKeyword
    case subKeyword
    case disabledKeyword
    case previewKeyword
}

class KeywordLabel: UILabel {
    
    private let horizontalInset: CGFloat = 16.0
    private let verticalInset: CGFloat = 13.0
    
    var keywordType: KeywordType?
    // enum으로 간략화 시켰는데 default를 그냥 중복되는게 제일 많은걸로 설정함 -> 이게 옳은 방법일지, 아니면 defaultKeyword를 default로 해야할지?
    private var maskedCorners: CACornerMask {
        switch keywordType {
        case .previewKeyword:
            return [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
        default:
            return [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
    }
    
    private var labelColor: [UIColor] {
        switch keywordType {
        case .defaultKeyword:
            return [.gradientBlueTop, .gradientBlueBottom]
        default:
            return [.white100, .white100]
        }
    }
    
    private var fontColor: UIColor {
        switch keywordType {
        case .defaultKeyword, .disabledKeyword:
            return .white100
        default:
            return .gray600
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + 2 * horizontalInset, height: size.height + 2 * verticalInset)
    }
    
    override var bounds: CGRect {
        didSet {
            preferredMaxLayoutWidth = bounds.width - 2 * horizontalInset
        }
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        setCornerRadius()
        setLabelColor()
        setFontColor()
        super.drawText(in: rect.inset(by: insets))
    }
    
    private func setCornerRadius() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = intrinsicContentSize.height * 0.5
        self.layer.maskedCorners = maskedCorners
    }
    
    private func setLabelColor() {
        self.setGradient(colorTop: labelColor[0], colorBottom: labelColor[1])
    }
    
    private func setFontColor() {
        self.textColor = .black
    }
}
