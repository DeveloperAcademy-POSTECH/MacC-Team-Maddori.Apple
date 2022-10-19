//
//  CloseButton.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/18.
//

import UIKit

import SnapKit

final class CloseButton: UIButton {

    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    private func configUI() {
        self.setImage(ImageLiterals.icClose, for: .normal)
        self.tintColor = .white
    }
    
    private func render() {
        self.snp.makeConstraints {
            $0.width.height.equalTo(44)
        }
    }
}
