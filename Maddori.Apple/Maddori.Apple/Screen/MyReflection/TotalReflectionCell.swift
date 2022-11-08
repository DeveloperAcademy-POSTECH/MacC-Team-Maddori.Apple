//
//  ReflectionCollectionViewCollectionCell.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/03.
//

import UIKit

import SnapKit

final class TotalReflectionCell: BaseCollectionViewCell {
    
    // MARK: - property
    
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.font = .body3
        return label
    }()
    private let cellDate: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .gray400
        return label
    }()
    private let cellArrow: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.icArrow
        imageView.tintColor = .gray400
        return imageView
    }()
    
    // MARK: - life cycle
    
    override func render() {
        contentView.addSubview(cellLabel)
        cellLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().inset(10)
        }
        
        contentView.addSubview(cellDate)
        cellDate.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(cellLabel.snp.bottom)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        contentView.addSubview(cellArrow)
        cellArrow.snp.makeConstraints {
            $0.trailing.equalTo(contentView.snp.trailing)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(12)
        }
    }
    
    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .white200
    }
    
    // MARK: - func
    
    func configLabel(text: String, date: String) {
        cellLabel.text = text
        cellDate.text = date
    }
}
