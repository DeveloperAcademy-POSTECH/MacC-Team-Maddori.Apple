//
//  KeywordCollectionViewHeader.swift
//  Maddori.Apple
//
//  Created by 이성민 on 12/31/23.
//

import UIKit

final class KeywordCollectionViewHeader: UICollectionReusableView {
    
    // MARK: - property
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .label2
        label.textColor = .black100
        return label
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) { nil }
    // MARK: - setup
    
    private func setupLayout() {
        self.addSubview(label)
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension KeywordCollectionViewHeader {
    func configureLabel(text: String) {
        self.label.text = text
    }
}
