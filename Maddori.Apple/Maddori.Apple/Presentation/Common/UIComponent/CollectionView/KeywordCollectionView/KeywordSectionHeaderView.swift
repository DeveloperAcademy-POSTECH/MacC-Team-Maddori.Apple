//
//  SectionHeaderView.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/10/25.
//

import UIKit

import SnapKit

final class KeywordSectionHeaderView: UICollectionReusableView {
    
    // MARK: - properties
    
    var label: UILabel = {
        let label = UILabel()
        label.font = .label2
        label.textColor = .black100
        return label
    }()
    
    // MARK: - life cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }

    required init?(coder: NSCoder) { nil }
    
    // MARK: - func
    
    private func render() {
        self.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
        }
    }
}
