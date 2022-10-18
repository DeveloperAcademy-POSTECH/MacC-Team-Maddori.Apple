//
//  KeywordLabel.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/10/18.
//

import UIKit

enum KeywordType {
    case blueLabel
    case whiteLabel
}

class KeywordLabel: UILabel {
    
    private let horizontalInset: CGFloat = 16.0
    private let verticalInset: CGFloat = 13.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        super.drawText(in: rect.inset(by: insets))
        setCornerRadius()
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
    
    private func setCornerRadius() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 24
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}
