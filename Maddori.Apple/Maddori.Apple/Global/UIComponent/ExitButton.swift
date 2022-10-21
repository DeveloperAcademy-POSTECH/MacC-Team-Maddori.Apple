//
//  ExitButton.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/10/18.
//

import UIKit

final class ExitButton: UIButton {
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        self.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        self.setImage(ImageLiterals.icClose, for: .normal)
        self.tintColor = .black100
    }
}
