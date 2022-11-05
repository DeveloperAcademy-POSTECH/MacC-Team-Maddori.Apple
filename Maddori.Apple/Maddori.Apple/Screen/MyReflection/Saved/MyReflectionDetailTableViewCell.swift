//
//  MyReflectionDetailTableViewCell.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2022/11/06.
//

import UIKit

import SnapKit

class MyReflectionDetailTableViewCell: BaseTableViewCell {
    
    // MARK: - property
    let titleLabel: UILabel = {
        let label = UILabel()
//        label.text = "필기 능력"
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
    let fromLabel: UILabel = {
        let label = UILabel()
        label.text = "메리"
        label.font = .caption2
        label.textColor = .gray400
        return label
    }()
    let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.text = "너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~ 너무 좋아요~"
        label.numberOfLines = 2
        label.textColor = .gray400
        label.setLineSpacing()
        return label
    }()
    
    // MARK: - init
    
    // MARK: - func
    override func render() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        self.addSubview(fromLabelBackView)
        fromLabelBackView.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(6)
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.width.equalTo(33)
            $0.height.equalTo(20)
        }
        
        fromLabelBackView.addSubview(fromLabel)
        fromLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        self.addSubview(contentLabel)
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.trailing.equalToSuperview().inset(66)
        }
    }
}
