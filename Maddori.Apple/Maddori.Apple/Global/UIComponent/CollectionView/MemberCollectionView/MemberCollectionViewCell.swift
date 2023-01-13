//
//  MemberCollectionViewCell.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/10/19.
//

import UIKit

import SnapKit

final class MemberCollectionViewCell: BaseCollectionViewCell {
    
    var index: FromCellIndex = .fromSelectMember
    
    var cellColor: UIColor = .white300 {
        didSet {
            memberLabel.backgroundColor = cellColor
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if index == FromCellIndex.fromAddFeedback {
                if isSelected {
                    applyAttribute()
                }
                else {
                    resetAttribute()
                }
            }
            else {
                setupAttribute()
            }
        }
    }
    
    // MARK: - property
    
    let memberLabel: UILabel = {
        let label = UILabel()
        label.font = .label1
        label.textColor = .black100
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        label.textAlignment = .center
        return label
    }()
    private lazy var memberShadow: UIView = {
        let view = UIView()
        view.frame = self.frame
        view.layer.cornerRadius = 8
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.2
        return view
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(memberShadow)
        memberShadow.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
                
        memberShadow.addSubview(memberLabel)
        memberLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - func
    
    func setupAttribute() {
        memberLabel.textColor = .gray300
        memberLabel.backgroundColor = .white100
        memberShadow.layer.shadowRadius = 1
    }
    
    private func applyAttribute() {
        if isSelected {
            memberLabel.layer.borderWidth = 2
            memberLabel.layer.cornerRadius = SizeLiteral.componentCornerRadius
            memberLabel.layer.borderColor = UIColor.blue200.cgColor
            memberLabel.textColor = .blue200
        }
    }
    
    private func resetAttribute() {
        memberLabel.layer.borderWidth = 0
        memberLabel.textColor = .black100
    }
}
