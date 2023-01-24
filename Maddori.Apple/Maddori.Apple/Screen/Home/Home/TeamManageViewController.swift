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
        view.backgroundColor = .red
    }
    
    // MARK: - func
    private func setupTableViewRegisterCell() {
        manageTableView.register(ParticipatingTeamCell.self, forCellReuseIdentifier: ParticipatingTeamCell.className)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ParticipatingTeamCell.className, for: indexPath) as? ParticipatingTeamCell else { return UITableViewCell() }
        return cell
    }
}

extension TeamManageViewController: UITableViewDelegate {
    
}
