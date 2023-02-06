//
//  TeamManageSettingCell.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2023/02/06.
//

import UIKit

import SnapKit

final class TeamManageSettingCell: BaseTableViewCell {
    
    // MARK: - property
    
    let cellTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .label2
        return label
    }()
    
    override func render() {
        self.addSubview(cellTitleLabel)
        cellTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
    }
    
    override func configUI() {
        self.backgroundColor = .white200
    }
}

final class TeamManageSettingFooterCell: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) { nil }
}
