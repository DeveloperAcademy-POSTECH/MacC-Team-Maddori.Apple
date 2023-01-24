//
//  TeamManageViewController.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2023/01/24.
//

import UIKit

import SnapKit

final class TeamManageViewController: BaseViewController {
    
    // MARK: - property
    private let manageTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewRegisterCell()
        setupTableViewDelegateDataSource()
    }
    
    override func render() {
        view.addSubview(manageTableView)
        manageTableView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(26)
            $0.horizontalEdges.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalToSuperview()
        }
    }
    
    override func configUI() {
        super.configUI()
    }
    
    // MARK: - func
    private func setupTableViewRegisterCell() {
        manageTableView.register(ParticipatingTeamCell.self, forCellReuseIdentifier: ParticipatingTeamCell.className)
        manageTableView.register(SettingCell.self, forCellReuseIdentifier: SettingCell.className)
    }
    
    private func setupTableViewDelegateDataSource() {
        manageTableView.delegate = self
        manageTableView.dataSource = self
    }
}

extension TeamManageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ParticipatingTeamCell.className, for: indexPath) as? ParticipatingTeamCell else { return UITableViewCell() }
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.className, for: indexPath) as? SettingCell else { return UITableViewCell() }
            return cell
        }
    }
}

extension TeamManageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //FIXME: 첫번째 그리고 세퍼레이터 변경 예정
        if indexPath.row == 0 {
            return 200
        }
        else {
            return 60
        }
    }
}
