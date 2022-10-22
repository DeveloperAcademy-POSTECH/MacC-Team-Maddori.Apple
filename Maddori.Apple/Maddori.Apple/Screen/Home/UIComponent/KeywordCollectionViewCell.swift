//
//  KeywordCollectionViewCell.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/10/21.
//

import UIKit

import SnapKit

class KeywordCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - properties
    
    var keywordLabel = UILabel()
    var keywordType: KeywordType = .previewKeyword
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("init keywordType", keywordType)
//        configCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func render() {
        contentView.addSubview(keywordLabel)
        keywordLabel.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
            $0.edges.equalToSuperview().inset(SizeLiteral.keywordLabelXInset)
        }
    }
    
    // MARK: - func
    
    func configCell() {
//        contentView.addSubview(keywordLabel)
//        keywordLabel.snp.makeConstraints {
//            $0.edges.equalTo(safeAreaLayoutGuide)
//            $0.edges.equalToSuperview().inset(SizeLiteral.keywordLabelXInset)
//        }
    }
    
    func configLabel(type: KeywordType) {
        keywordLabel.textAlignment = .center
        keywordLabel.font = .main
        keywordLabel.layer.cornerRadius = SizeLiteral.keywordLabelHeight / 2
        keywordLabel.layer.masksToBounds = true
        
        keywordLabel.textColor = type.textColor
        keywordLabel.backgroundColor = type.labelColor[0]
        keywordLabel.layer.maskedCorners = type.maskedCorners
    }
    
    func configShadow(type: KeywordType) {
        layer.shadowOpacity = type.shadowOpacity
        layer.shadowRadius = type.shadowRadius
        layer.shadowOffset = type.shadowOffset
        layer.maskedCorners = type.maskedCorners
    }
    
    func configLabelText(keyword: String?) {
        keywordLabel.text = keyword
    }
    
    static func fittingSize(availableHeight: CGFloat, keyword: String?) -> CGSize {
        let cell = KeywordCollectionViewCell()
        cell.configLabelText(keyword: keyword)
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
        return cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }
}
