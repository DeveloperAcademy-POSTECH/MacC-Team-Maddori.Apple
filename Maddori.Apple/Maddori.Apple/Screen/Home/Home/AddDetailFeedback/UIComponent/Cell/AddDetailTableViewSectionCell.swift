//
//  AddDetailTableViewSectionCell.swift
//  Maddori.Apple
//
//  Created by LeeSungHo on 2022/12/06.
//

import UIKit

import SnapKit

final class AddDetailTableViewSectionCell: BaseTableViewCell {
    
    // MARK: - property
    
    let cellTitle: UILabel = {
        let label = UILabel()
        label.font = .main
        return label
    }()
    
    // MARK: - life cycle
    
    override func configUI() {
        // FIXME: 색 변경할것
//        self.backgroundColor = .red
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.black100.cgColor
//        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        self.layer.addBorder([.top, .left, .right], color: .black100, width: 0.5)
        
    }
    
    override func render() {
        self.addSubview(cellTitle)
        cellTitle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(19)
        }
    }
}
