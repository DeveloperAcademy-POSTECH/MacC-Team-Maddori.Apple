//
//  AddDetailTableViewSelectMemberCell.swift
//  Maddori.Apple
//
//  Created by LeeSungHo on 2022/12/06.
//

import UIKit

import SnapKit

final class AddDetailTableViewSelectMemberCell: BaseTableViewCell {
    
    // MARK: - property
    
    // MARK: - life cycle
    
    override func configUI() {
        self.layer.borderWidth = 0.2
        self.layer.borderColor = UIColor.black100.cgColor
        self.layer.cornerRadius = 10
    }
    
}
