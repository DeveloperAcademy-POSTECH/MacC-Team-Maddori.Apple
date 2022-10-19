//
//  BackButton.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/10/19.
//

import UIKit

final class BackButton: UIButton {
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configUI()
    }
    
    private func configUI() {
        self.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        self.setImage(ImageLiterals.icBack, for: .normal)
        self.tintColor = .black100
    }
}
