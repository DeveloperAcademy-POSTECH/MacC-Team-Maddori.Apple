//
//  TeamDetailMemberCollectionView.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2023/02/02.
//

import UIKit

import SnapKit

final class TeamDetailMembersView: UIView {
    
    // FIXME: - API연결 후 수정
    let members: [String] = Array(repeating: "", count: 2)
    
    enum PropertySize {
        static let headerViewHeight: CGFloat = 70
        static let cellSize: CGFloat = 46
        static let cellSpacing: CGFloat = 20
        static let navigationBarHeight: CGFloat = 44
        static let homeIndicatorHeight: CGFloat = 34
        static let tableViewTopProperty: CGFloat = 86
        static let tableViewBottomProperty: CGFloat = 120
    }
    
    // MARK: - property
    
    private let memberTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .backgroundWhite
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.register(TeamDetailMemberTableHeaderView.self, forHeaderFooterViewReuseIdentifier: TeamDetailMemberTableHeaderView.className)
        tableView.register(TeamDetailMemberTableViewCell.self, forCellReuseIdentifier: TeamDetailMemberTableViewCell.className)
        return tableView
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        setupDelegation()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - func
    
    private func render() {
        self.addSubview(memberTableView)
        memberTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupDelegation() {
        memberTableView.delegate = self
        memberTableView.dataSource = self
    }
}

// MARK: - extension

extension TeamDetailMembersView: UITableViewDelegate {
    
}

extension TeamDetailMembersView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TeamDetailMemberTableViewCell.className, for: indexPath) as? TeamDetailMemberTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PropertySize.cellSize + PropertySize.cellSpacing
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TeamDetailMemberTableHeaderView.className) as? TeamDetailMemberTableHeaderView else { return UITableViewHeaderFooterView() }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return PropertySize.headerViewHeight + PropertySize.cellSpacing
    }
}
