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
    private let tempView: UIView = {
        let view = UIView()
        return view
    }()
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        return view
    }()
    private let settingTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        configureSettingModels()
    }
    
    override func render() {
        view.addSubview(tempView)
        tempView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(275) // FIXME: 수치 바꿀것
            $0.top.equalToSuperview()
        }
        
        view.addSubview(dividerView)
        dividerView.snp.makeConstraints {
            $0.top.equalTo(tempView.snp.bottom)
            $0.width.equalToSuperview()
            $0.height.equalTo(6)
        }
        
        view.addSubview(settingTableView)
        settingTableView.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom)
            $0.width.equalToSuperview()
            $0.height.equalTo(500) // FIXME: 수치 바꿀것
        }
    }
    
    override func configUI() {
        super.configUI()
    }
    
    // MARK: - func
    private func setupDelegate() {
        settingTableView.delegate = self
        settingTableView.dataSource = self
    }
    
    private func configureSettingModels() {
        sections.append(Section(title: "위", options: [Option(title: "새로운 팀 합류하기", handler: {
            print("새로운 팀 합류하기")
        }),
                                                      Option(title: "팀 생성하기", handler: {
            print("팀 생성하기")
        })]))
        
        sections.append(Section(title: "아래", options: [Option(title: "로그아웃", handler: {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.title
        return cell
    }
}

extension TeamManageViewController: UITableViewDelegate {
    
}

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
