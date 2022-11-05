//
//  MyReflectionDetailTableViewCell.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2022/11/06.
//

import UIKit

import SnapKit

class MyReflectionDetailTableViewCell: BaseTableViewCell {
    
    // MARK: - property
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "필기 능력"
        label.font = .label1
        label.textColor = .black100
        return label
    }()
    
    
    // MARK: - init
    
    // MARK: - func
    override func render() {
        
    }
}
