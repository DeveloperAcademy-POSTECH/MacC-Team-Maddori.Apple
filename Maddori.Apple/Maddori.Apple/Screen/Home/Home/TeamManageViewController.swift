//
//  TeamManageViewController.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2023/01/24.
//

import UIKit

import SnapKit

final class TeamManageViewController: BaseViewController {
    
    private var sections: [Section] = []
    
    // MARK: - property
    
    private let chageTeamView: ChangeTeamView = {
        let view = ChangeTeamView()
        return view
    }()
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        return view
    }()
    private let settingTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TeamManageSettingCell.self, forCellReuseIdentifier: TeamManageSettingCell.className)
        tableView.register(TeamManageSettingFooterCell.self, forHeaderFooterViewReuseIdentifier: TeamManageSettingFooterCell.className)
        tableView.isScrollEnabled = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: SizeLiteral.leadingTrailingPadding, bottom: 0, right: SizeLiteral.leadingTrailingPadding)
        return tableView
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        configureSettingModels()
    }
    
    override func render() {
        view.addSubview(chageTeamView)
        chageTeamView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(275) // FIXME: 수치 바꿀것
            $0.top.equalToSuperview()
        }
        
        view.addSubview(dividerView)
        dividerView.snp.makeConstraints {
            $0.top.equalTo(chageTeamView.snp.bottom)
            $0.width.equalToSuperview()
            $0.height.equalTo(6)
        }
        
        view.addSubview(settingTableView)
        settingTableView.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom)
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(1000) // FIXME: 수치 바꿀것
        }
    }
    
    // MARK: - func
    
    private func setupDelegate() {
        settingTableView.delegate = self
        settingTableView.dataSource = self
    }
    
    private func configureSettingModels() {
        sections.append(Section(options: [Option(title: "새로운 팀 합류하기", handler: {
            print("새로운 팀 합류하기")
        }),
                                          Option(title: "팀 생성하기", handler: {
            print("팀 생성하기")
        })]))
        sections.append(Section(options: [Option(title: "로그아웃", handler: {
            print("로그아웃")
        }),
                                          Option(title: "회원탈퇴", handler: {
            print("회원탈퇴")
        })]))
    }
}

extension TeamManageViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].options[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TeamManageSettingCell.className, for: indexPath) as? TeamManageSettingCell else { return UITableViewCell() }
        
        if indexPath.section == 1 {
            cell.cellTitleLabel.textColor = .red100
        }
        
        cell.cellTitleLabel.text = model.title
        cell.selectionStyle = .none
        
        if indexPath.row == sections.count - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: tableView.bounds.width + 1, bottom: 0, right: 0)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: TeamManageSettingFooterCell.className) as? TeamManageSettingFooterCell else { return UITableViewHeaderFooterView()
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor = .gray100
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 6
    }
}

extension TeamManageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = sections[indexPath.section].options[indexPath.row]
        model.handler()
    }
}
