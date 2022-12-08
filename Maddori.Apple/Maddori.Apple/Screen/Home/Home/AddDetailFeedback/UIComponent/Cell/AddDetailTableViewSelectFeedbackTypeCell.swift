//
//  AddDetailTableViewSelectFeedbackTypeCell.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2022/12/08.
//

import UIKit

import SnapKit

final class AddDetailTableViewSelectFeedbackTypeCell: BaseTableViewCell {
    
    // MARK: - property
    
    // MARK: - life cycle
    
    override func configUI() {
        self.layer.borderWidth = 0.2
        self.layer.borderColor = UIColor.black100.cgColor
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
}
