//
//  KeywordCollectionViewCell.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/10/21.
//

import UIKit

import SnapKit

final class KeywordCollectionViewCell: BaseCollectionViewCell {
    
    private enum Size {
        static let keywordLabelHeight: CGFloat = 50
        static let keywordLabelXInset: CGFloat = 17
    }
    
    // MARK: - properties
    
    lazy var keywordLabel: KeywordLabel = {
        let label = KeywordLabel()
        label.textAlignment = .center
        label.font = .main
        label.layer.cornerRadius = Size.keywordLabelHeight / 2
        label.layer.masksToBounds = true
        return label
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func render() {
        contentView.addSubview(keywordLabel)
        keywordLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - func
    
    func configLabel(type: KeywordType) {
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
    
    func setupAttribute(to style: KeywordType) {
        configLabel(type: style)
        configShadow(type: style)
    }
    
    static func fittingSize(availableHeight: CGFloat, keyword: String?) -> CGSize {
        let cell = KeywordCollectionViewCell()
        cell.configLabelText(keyword: keyword)
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
        return cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }
}
