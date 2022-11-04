//
//  ReflectionCollectionViewSpecialCell.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/03.
//

import UIKit

import SnapKit

final class SpecialReflectionCell: BaseCollectionViewCell {
    
    // MARK: - property
    
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.font = .body3
        return label
    }()
    private let cellArrow: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.icArrow
        imageView.tintColor = .gray400
        return imageView
    }()
    
    // MARK: - func
    
    override func render() {
        contentView.addSubview(cellLabel)
        cellLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(15)
        }
        
        contentView.addSubview(cellArrow)
        cellArrow.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(12)
        }
    }
    
    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .white200
    }
    
    func configLabel(text: String) {
        cellLabel.text = text
    }
}
