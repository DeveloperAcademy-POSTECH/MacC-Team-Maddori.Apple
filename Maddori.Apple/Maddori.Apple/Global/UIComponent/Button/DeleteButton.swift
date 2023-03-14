//
//  DeleteButton.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2023/02/07.
//

import UIKit

import SnapKit

final class DeleteButton: UIButton {
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func configUI() {
        self.setTitle("삭제", for: .normal)
        self.setTitleColor(.red100, for: .normal)
    }
    
    private func render() {
        self.snp.makeConstraints {
            $0.width.height.equalTo(44)
        }
    }
}

