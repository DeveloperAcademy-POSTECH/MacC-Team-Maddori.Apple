//
//  MyReflectionDetailTableViewCell.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2022/11/06.
//

import UIKit

import SnapKit

final class MyReflectionDetailTableViewCell: BaseTableViewCell {
    
    // MARK: - property
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .label1
        label.textColor = .black100
        return label
    }()
    private let fromLabelBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        view.layer.cornerRadius = 4
        return view
    }()
    private let fromLabel: UILabel = {
        let label = UILabel()
        label.font = .caption2
        label.textColor = .gray400
        return label
    }()
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.numberOfLines = 2
        label.textColor = .gray400
        return label
    }()
    private let rightImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.icRight
        imageView.tintColor = .gray400
        return imageView
    }()
    private let cellDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray300
        return view
    }()
    
    // MARK: - life cycle
    
    override func configUI() {
        backgroundColor = .backgroundWhite
    }
    
    override func render() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        contentView.addSubview(fromLabelBackView)
        fromLabelBackView.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(6)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        fromLabelBackView.addSubview(fromLabel)
        fromLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(3)
            $0.bottom.equalToSuperview().inset(2)
            $0.horizontalEdges.equalToSuperview().inset(4)
        }
        
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.trailing.equalToSuperview().inset(66)
        }
        
        contentView.addSubview(rightImage)
        rightImage.snp.makeConstraints {
            $0.centerY.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.width.equalTo(12)
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(cellDivider)
        cellDivider.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
    
    // MARK: - func
    
    func configLabel(title: String, fromLabel: String, content: String) {
        DispatchQueue.main.async {
            self.titleLabel.text = title
            self.fromLabel.text = fromLabel
            self.contentLabel.setTextWithLineHeight(text: content, lineHeight: 22)
        }
    }
}
