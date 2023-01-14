//
//  KigoTextField.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2022/10/18.
//

import UIKit

import SnapKit

final class CustomTextField: UITextField {
    private enum Size {
        static let width: CGFloat = UIScreen.main.bounds.width - (SizeLiteral.leadingTrailingPadding * 2)
        static let height: CGFloat = 56
    }
    
    var placeHolderText: String? {
        didSet { setupAttribute() }
    }
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func configUI() {
        self.backgroundColor = .white300
        self.font = .body1
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray100.cgColor
        self.layer.cornerRadius = 10
        self.textAlignment = .left
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 0))
        self.leftView = leftPaddingView
        self.leftViewMode = .always
    }
    
    private func render() {
        self.snp.makeConstraints {
            $0.width.equalTo(Size.width)
            $0.height.equalTo(Size.height)
        }
    }
    
    // MARK: - func
    
    private func setupAttribute() {
        let attributes = [
            NSAttributedString.Key.font : UIFont.body1,
            NSAttributedString.Key.foregroundColor : UIColor.gray500
        ]
        self.attributedPlaceholder = NSAttributedString(string: placeHolderText ?? "", attributes: attributes)
        
    }
}
