//
//  MyFeedbackCollectionViewCell.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/02.
//

import UIKit

import SnapKit

final class MyFeedbackCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - property
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .label1
        label.textColor = .black100
        return label
    }()
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .gray400
        label.numberOfLines = 2
        return label
    }()
    private let rightImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.icRight
        imageView.tintColor = .gray400
        return imageView
    }()
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray300
        return view
    }()
    
    // MARK: - life cycle
    
    override func configUI() {
        backgroundColor = .backgroundWhite
    }
    
    override func render() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        self.addSubview(contentLabel)
        contentLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(66)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        self.addSubview(rightImage)
        rightImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.width.equalTo(12)
            $0.height.equalTo(20)
        }
        
        self.addSubview(dividerView)
        dividerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
    
    // MARK: - func
    
    func setCellLabel(title: String, content: String) {
        titleLabel.text = title
        contentLabel.setTextWithLineHeight(text: content, lineHeight: 22)
    }
    
    func setDividerHidden(_ value: Bool) {
        dividerView.isHidden = value
    }
}
