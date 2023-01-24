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
    private let label = UILabel()
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
        label.text = "테스트느트트트"
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.left.equalToSuperview().inset(40)
        }
        
        view.addSubview(manageTableView)
        manageTableView.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom)
            $0.width.equalTo(200)
            $0.height.equalTo(600)
        }
    }
    
    override func configUI() {
        super.configUI()
        view.backgroundColor = .red
    }
    
    // MARK: - func
    private func setupTableViewRegisterCell() {
        manageTableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.className)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.className, for: indexPath) as? UITableViewCell else { return UITableViewCell() }
        return cell
    }
}

extension TeamManageViewController: UITableViewDelegate {
    
}
