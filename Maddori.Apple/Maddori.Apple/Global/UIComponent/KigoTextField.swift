//
//  KigoTextField.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2022/10/18.
//

import UIKit

import SnapKit

final class KigoTextField: UITextField {
    private enum Size {
        static let width: CGFloat = UIScreen.main.bounds.width - (SizeLiteral.leadingTrailingPadding * 2)
        static let height: CGFloat = 56
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - property
    
    var inText: String? {
        didSet { setupAttribute() }
    }
    
    // MARK: - function
    
    private func configUI() {
        self.backgroundColor = .white300
        self.font = .body1
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white300.cgColor
        self.textAlignment = .left
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        self.leftView = leftPaddingView
        self.leftViewMode = .always
    }
    
    private func render() {
        self.snp.makeConstraints {
            $0.width.equalTo(Size.width)
            $0.height.equalTo(Size.height)
        }
    }
    
    private func setupAttribute() {
        let attributes = [
            NSAttributedString.Key.font : UIFont.body1,
            NSAttributedString.Key.foregroundColor : UIColor.gray500
        ]
        self.attributedPlaceholder = NSAttributedString(string: inText ?? "", attributes: attributes)
        
    }
}
