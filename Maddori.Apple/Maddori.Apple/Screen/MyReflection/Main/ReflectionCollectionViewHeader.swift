//
//  ReflectionCollectionViewHeader.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/02.
//

import UIKit

import SnapKit

final class ReflectionCollectionViewHeader: UICollectionReusableView {
    
    // MARK: - property
    
    private lazy var headerIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.icBox
        imageView.tintColor = UIColor.blue200
        return imageView
    }()
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.MyReflectionViewHeaderHeaderLabel
        label.font = .label3
        return label
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configUI()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func render() {
        self.addSubview(headerIcon)
        headerIcon.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(6)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.width.equalTo(28)
        }
        
        self.addSubview(headerLabel)
        headerLabel.snp.makeConstraints {
            $0.bottom.equalTo(headerIcon).offset(-3)
            $0.leading.equalTo(headerIcon.snp.trailing).offset(5)
        }
    }
    
    private func configUI() {
        self.backgroundColor = .white200
    }
}
