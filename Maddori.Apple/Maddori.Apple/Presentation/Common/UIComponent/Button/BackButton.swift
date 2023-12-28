//
//  BackButton.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/10/19.
//

import UIKit

import SnapKit

final class BackButton: UIButton {
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func configUI() {
        self.setImage(ImageLiterals.icBack, for: .normal)
        self.tintColor = .black100
    }
    
    private func render() {
        self.snp.makeConstraints {
            $0.width.height.equalTo(44)
        }
    }
}
