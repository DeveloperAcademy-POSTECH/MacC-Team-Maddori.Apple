//
//  KeywordCollectionViewCell.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/10/21.
//

import UIKit

import SnapKit

class KeywordCollectionViewCell: BaseCollectionViewCell {
    
    private enum Size {
        static let keywordLabelHeight: CGFloat = 50
        // FIXME: 기존에는 16 이었는데 그렇게 하면 한 글자일 때 cornerRadius 때문에 뾰족해짐
        static let keywordLabelXInset: CGFloat = 17
    }
    
    // MARK: - properties
    
    var keywordLabel = UILabel()
    lazy var keywordType: KeywordType = .previewKeyword
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - func
    
    func configCell() {
        contentView.addSubview(keywordLabel)
        keywordLabel.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
            $0.edges.equalToSuperview().inset(Size.keywordLabelXInset)
        }
    }
    
    func configLabel(type: KeywordType) {
        keywordLabel.textAlignment = .center
        keywordLabel.font = .main
        keywordLabel.layer.cornerRadius = Size
            .keywordLabelHeight / 2
        keywordLabel.layer.masksToBounds = true
        
        keywordLabel.textColor = type.textColor
        keywordLabel.backgroundColor = type.labelColor[0]
        keywordLabel.layer.maskedCorners = type.maskedCorners
    }
    
    func configShadow(type: KeywordType) {
        layer.shadowColor = type.shadowColor
        layer.shadowOpacity = type.shadowOpacity
        layer.shadowRadius = type.shadowRadius
        layer.shadowOffset = type.shadowOffset
        layer.maskedCorners = type.maskedCorners
    }
    
    func configLabelText(keyword: String?) {
        keywordLabel.text = keyword
    }
    
    func configLableType(type: KeywordType) {
        keywordType = type
    }
    
    static func fittingSize(availableHeight: CGFloat, keyword: String?) -> CGSize {
        let cell = KeywordCollectionViewCell()
        cell.configLabelText(keyword: keyword)
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
        return cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }
}
