//
//  FullDividerView.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2023/02/07.
//

import UIKit

import SnapKit

final class FullDividerView: UIView {
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray300
    }
    
    required init?(coder: NSCoder) { nil }
}
