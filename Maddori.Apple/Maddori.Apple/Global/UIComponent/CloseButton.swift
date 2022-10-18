//
//  CloseButton.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/18.
//

import UIKit

final class CloseButton: UIButton {

    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: .init(origin: .zero, size: .init(width: 44, height: 44)))
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    private func configUI() {
        self.setImage(ImageLiterals.icClose, for: .normal)
        self.tintColor = .white
    }
}
