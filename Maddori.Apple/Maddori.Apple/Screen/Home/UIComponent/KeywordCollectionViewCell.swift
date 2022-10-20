//
//  KeywordCollectionViewCell.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/10/21.
//

import UIKit

class KeywordCollectionViewCell: UICollectionViewCell {
    
    var keywordLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
        setupLabel()
    }
    
    func setupCell() {
        keywordLabel = UILabel()
        contentView.addSubview(keywordLabel)
        keywordLabel.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
            $0.edges.equalToSuperview().inset(15)
        }
    }
    
    func setupLabel() {
        keywordLabel.textAlignment = .center
        keywordLabel.textColor = .black
        keywordLabel.backgroundColor = .white
        keywordLabel.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
        keywordLabel.layer.cornerRadius = 45 / 2
        keywordLabel.layer.masksToBounds = true
    }
    
    func configure(keyword: String?) {
        keywordLabel.text = keyword
    }
    
    static func fittingSize(availableHeight: CGFloat, keyword: String?) -> CGSize {
        print("\(keyword)")
        let cell = KeywordCollectionViewCell()
        cell.configure(keyword: keyword)
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
        return cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }
}
