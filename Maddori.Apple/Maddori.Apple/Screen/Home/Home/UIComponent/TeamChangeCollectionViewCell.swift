//
//  TeamChangeCollectionViewCell.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2023/02/07.
//

import UIKit

import SnapKit

final class TeamChangeCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - property
    
    let teamNameLabel: UILabel = {
        let label = UILabel()
        label.font = .label2
        label.textColor = .black100
        return label
    }()

    // MARK: - life cycle
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                applyAttribute()
            }
            else {
                resetAttribute()
            }
        }
    }
    
    override func render() {
        contentView.addSubview(teamNameLabel)
        teamNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
    }
    
    override func configUI() {
        self.backgroundColor = .white200
        self.layer.cornerRadius = 10
        self.makeShadow(color: .black100, opacity: 0.3, offset: CGSize(width: 0, height: 0), radius: 1)
        self.layer.masksToBounds = false
        
    }
    
    // MARK: - func
    
    private func setBorder(color: CGColor, width: CGFloat) {
        self.layer.borderColor = color
        self.layer.borderWidth = width
    }
    
    private func applyAttribute() {
        if isSelected {
            self.layer.borderWidth = 2
            self.layer.borderColor = UIColor.blue200.cgColor
        }
    }

    private func resetAttribute() {
        self.layer.borderWidth = 0
    }
}
