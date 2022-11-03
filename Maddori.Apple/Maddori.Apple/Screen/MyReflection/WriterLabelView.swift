//
//  writerLabelView.swift
//  Maddori.Apple
//
//  Created by LeeSungHo on 2022/11/03.
//

import UIKit

import SnapKit

final class WriterLabelView: UIView {
    
    // MARK: - property
    
    private let writerLabel: UILabel = {
        let label = UILabel()
        label.text = "메리"
        label.font = .caption2
        label.textColor = .gray400
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
        self.addSubview(writerLabel)
        writerLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func configUI() {
        self.layer.cornerRadius = 4
        self.backgroundColor = .gray100
    }
}
