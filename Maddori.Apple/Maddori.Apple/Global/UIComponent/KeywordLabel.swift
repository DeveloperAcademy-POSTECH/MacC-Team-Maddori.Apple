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

final class KeywordLabel: UILabel {
    
    private let horizontalInset: CGFloat = 16.0
    private let verticalInset: CGFloat = 13.0
    
    var keywordType: KeywordType?
    
    private var maskedCorners: CACornerMask {
        switch keywordType {
        case .previewKeyword:
            return [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
        default:
            return [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
    }
    
    var labelColor: [UIColor] {
        switch keywordType {
        case .defaultKeyword:
            return [.gradientBlueTop, .gradientBlueBottom]
        default:
            return [.white100, .white100]
        }
    }
    
    private var customTextColor: UIColor {
        switch keywordType {
        case .defaultKeyword:
            return .white100
        case .disabledKeyword:
            return .gray300
        default:
            return .gray600
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: (horizontalInset * 2) + size.width,
                      height: (verticalInset * 2) + size.height)
    }
    
    override var bounds: CGRect {
        didSet {
            preferredMaxLayoutWidth = (horizontalInset * (-2)) + bounds.width 
        }
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        self.font = UIFont.main
        setCornerRadius()
        setTextColor()
        setLabelColor()
        super.drawText(in: rect.inset(by: insets))
//        TODO: 2차 스프린트 때 그라디언트 넣기
//        let textLayer = CATextLayer()
//        textLayer.frame = self.bounds
//        textLayer.alignmentMode = .center
//        textLayer.position = CGPoint(x: 0, y: intrinsicContentSize.height * 0.5)
//        textLayer.fontSize = 18.0
//        textLayer.font = UIFont.main
//        textLayer.foregroundColor = fontColor.cgColor
//        textLayer.string = self.text
//        self.layer.addSublayer(textLayer)
    }
    
    private func setCornerRadius() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = intrinsicContentSize.height * 0.5
        self.layer.maskedCorners = maskedCorners
    }
    
    private func setLabelColor() {
        self.backgroundColor = labelColor[0]
//         TODO: 2차 스프린트 때 그라디언트 넣기
//         self.setGradient(colorTop: labelColor[0], colorBottom: labelColor[1])
    }
    
    private func setTextColor() {
        self.textColor = customTextColor
    }
}
