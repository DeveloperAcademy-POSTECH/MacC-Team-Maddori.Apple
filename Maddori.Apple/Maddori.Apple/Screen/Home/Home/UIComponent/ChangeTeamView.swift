//
//  ChangeTeamView.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2023/02/06.
//

import UIKit

import SnapKit

final class ChangeTeamView: UIView {
    
    // MARK: - property
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .label2
        label.text = "참여 중인 팀"
        label.textColor = .black100
        return label
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configUI()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func configUI() {
        self.backgroundColor = .white200
    }
    
    private func render() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(26)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
    }
    
    // MARK: - function
    

    
}
