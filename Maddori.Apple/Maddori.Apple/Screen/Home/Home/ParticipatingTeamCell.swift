//
//  ParticipatingTeamCell.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2023/01/24.
//

import UIKit

import SnapKit

final class ParticipatingTeamCell: BaseTableViewCell {
    
    // MARK: - property
    private let titleLable: UILabel = {
        let label = UILabel()
        label.text = "참여 중인 팀"
        label.font = .label2
        return label
    }()
    let listTableView = UITableView()
    
    // MARK: - life cycle

    override func render() {
        
        self.addSubview(titleLable)
        titleLable.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(SizeLiteral.leadingTrailingPadding)
        }
        
        self.addSubview(listTableView)
        listTableView.snp.makeConstraints {
            $0.top.equalTo(titleLable.snp.bottom).offset(10)
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }
    
    override func configUI() {
        backgroundColor = .white100
    }
    
    // MARK: - func
    private func setupTableViewCell() {
        listTableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.className)
    }
}
