//
//  MainButton.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/14.
//

import UIKit

import SnapKit

final class MainButton: UIButton {
    private enum Size {
        static let width: CGFloat = UIScreen.main.bounds.width - (SizeLiteral.leadingTrailingPadding * 2)
        static let height: CGFloat = 54
    }
    
    var title: String? {
        didSet { setupAttribute() }
    }
    
    var isDisabled: Bool = false {
        didSet { setupAttribute() }
    }
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configUI()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func configUI() {
        layer.masksToBounds = true
        layer.cornerRadius = 10
        titleLabel?.font = .font(.bold, ofSize: 18)
        setTitleColor(.white, for: .normal)
        setTitleColor(.white, for: .disabled)
        setBackgroundColor(.blue200, for: .normal)
        setBackgroundColor(.gray200, for: .disabled)
    }
    
    private func render() {
        self.snp.makeConstraints {
            $0.width.equalTo(Size.width)
            $0.height.equalTo(Size.height)
        }
    }
    
    // MARK: - func
    
    private func setupAttribute() {
        if let title = title {
            setTitle(title, for: .normal)
        }
        
        isEnabled = !isDisabled
    }
}
