//
//  SettingButton.swift
//  Maddori.Apple
//
//  Created by LeeSungHo on 2022/11/23.
//

import UIKit

import SnapKit

final class SettingButton: UIButton {
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func configUI() {
        self.setImage(.load(systemName: "ellipsis"), for: .normal)
        self.tintColor = .black100
    }
    
    private func render() {
        self.snp.makeConstraints {
            $0.width.height.equalTo(44)
        }
    }
}
