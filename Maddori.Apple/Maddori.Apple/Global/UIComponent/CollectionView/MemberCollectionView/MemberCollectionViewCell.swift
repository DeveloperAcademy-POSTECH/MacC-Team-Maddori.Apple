//
//  MemberCollectionViewCell.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/10/19.
//

import UIKit

import SnapKit

final class MemberCollectionViewCell: BaseCollectionViewCell {
    
    var index = 0
    
    private enum Size {
        static let width = 135
        static let height = 60
        static let frame = CGRect(x: 0, y: 0, width: Size.width, height: Size.height)
    }
    

    override var isSelected: Bool {
        didSet {
            if index == FromCellIndex.fromAddFeedback.rawValue {
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
        label.backgroundColor = .white300
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        label.textAlignment = .center
        return label
    }()
    private let memberShadow: UIView = {
        let view = UIView()
        view.frame = Size.frame
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
            $0.width.equalTo(Size.width)
            $0.height.equalTo(Size.height)
        }
                
        memberShadow.addSubview(memberLabel)
        memberLabel.snp.makeConstraints {
            $0.width.equalTo(Size.width)
            $0.height.equalTo(Size.height)
        }
    }
    
    // MARK: - func
    
    func setupAttribute() {
        if isSelected {
            memberLabel.textColor = .gray300
            memberLabel.backgroundColor = .white100
            memberShadow.layer.shadowRadius = 1
        }
    }
    
    func applyAttribute() {
        if isSelected {
            memberLabel.layer.borderWidth = 2
            memberLabel.layer.cornerRadius = SizeLiteral.componentCornerRadius
            memberLabel.layer.borderColor = UIColor.blue200.cgColor
            memberLabel.textColor = .blue200
        }
    }
    
    func resetAttribute() {
        memberLabel.layer.borderWidth = 0
        memberLabel.textColor = .black100
    }
}
