//
//  MyBoxMemberCollectionViewCell.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/02.
//

import UIKit

import SnapKit

final class MyBoxMemberCollectionViewCell: BaseCollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                setSelectedCellLayer()
            } else {
                setShadowLayer()
            }
        }
    }
    
    // MARK: - property
    
    private let shadowView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 30
        view.backgroundColor = .white
        view.makeShadow(color: .black, opacity: 0.25, offset: CGSize.zero, radius: 1)
        return view
    }()
    private let memberNameLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .gray400
        return label
    }()
    
    // MARK: - life cycle
    
    override func configUI() {
        setShadowLayer()
    }
    
    override func render() {
        self.addSubview(shadowView)
        shadowView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.addSubview(memberNameLabel)
        memberNameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - func
    
    private func setSelectedCellLayer() {
        self.layer.cornerRadius = 30
        self.layer.borderColor = UIColor.blue200.cgColor
        self.layer.borderWidth = 2
        self.layer.shadowOpacity = 0
        memberNameLabel.textColor = .blue200
    }
    
    private func setShadowLayer() {
        self.layer.cornerRadius = 30
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.clear.cgColor
        self.makeShadow(color: .black, opacity: 0.25, offset: CGSize.zero, radius: 1)
        memberNameLabel.textColor = .gray400
    }
    
    func setMemeberName(name: String) {
        memberNameLabel.text = name
    }
}
