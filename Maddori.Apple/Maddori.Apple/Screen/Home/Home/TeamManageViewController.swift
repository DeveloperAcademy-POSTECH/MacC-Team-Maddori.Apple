//
//  TeamManageViewController.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2023/01/24.
//

import UIKit

import Alamofire
import SnapKit

final class TeamManageViewController: BaseViewController {
    
    private enum Size {
        static let teamSectionHeight = 59
        static let teamSectionSpacing = 8
        static let teamSectionPadding = 28
        static let teamTitleLabelHeight = 50
    }
    
    private var sections: [Section] = []
    private lazy var teamCount = 0 {
        didSet {
            changeTeamView.snp.updateConstraints {
                $0.height.equalTo((teamCount * Size.teamSectionHeight) + ((teamCount - 1) * Size.teamSectionSpacing) + Size.teamSectionPadding + Size.teamTitleLabelHeight)
            }
        }
    }
    
    // MARK: - property
    
    private let changeTeamView = ChangeTeamView()
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        return view
    }()
    private let settingTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TeamManageSettingCell.self, forCellReuseIdentifier: TeamManageSettingCell.className)
        tableView.register(TeamManageSettingFooterView.self, forHeaderFooterViewReuseIdentifier: TeamManageSettingFooterView.className)
        tableView.isScrollEnabled = false
        tableView.separatorInset = UIEdgeInsets(top: 0,
                                                left: SizeLiteral.leadingTrailingPadding,
                                                bottom: 0,
                                                right: SizeLiteral.leadingTrailingPadding)
        return tableView
    }()
    private let scrollView: UIScrollView = UIScrollView()
    private let contentView: UIView = UIView()
    
    private var currentTeamId: Int
    
    // MARK: - life cycle
    
    init(teamId: Int) {
        self.currentTeamId = teamId
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        configureSettingModels()
        fetchUserTeamList(type: .fetchUserTeamList)
        setChangeTeamViewDelegate()
    }
    
    override func render() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
 
        contentView.addSubview(changeTeamView)
        changeTeamView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        contentView.addSubview(dividerView)
        dividerView.snp.makeConstraints {
            $0.top.equalTo(changeTeamView.snp.bottom)
            $0.width.equalToSuperview()
            $0.height.equalTo(6)
        }
        
        contentView.addSubview(settingTableView)
        settingTableView.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom)
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(252)
        }
    }
    
    // MARK: - func
    
    private func setChangeTeamViewDelegate() {
        changeTeamView.delegate = self
    }
    
    private func setCurrentTeam() {
        changeTeamView.currentTeamId = currentTeamId
    }
    
    private func setupDelegate() {
        settingTableView.delegate = self
        settingTableView.dataSource = self
    }
    
    private func configureSettingModels() {
        sections.append(Section(options: [Option(title: TextLiteral.teamManageViewControllerJoinNewTeam, handler: {
            self.joinNewTeam()
        }),
                                          Option(title: TextLiteral.teamManageViewControllerCreateTeam, handler: {
            self.createTeam()
        })]))
        sections.append(Section(options: [Option(title: TextLiteral.teamManageViewControllerLoggout, handler: {
            self.logout()
        }),
                                          Option(title: TextLiteral.teamManageViewControllerWithdrawl, handler: {
            self.withdrawal()
        })]))
    }
    
    private func joinNewTeam() {
        let rootView = presentingViewController
        dismiss(animated: true) {
            let joinViewController = UINavigationController(rootViewController: JoinTeamViewController(from: .teamManageView))
            joinViewController.modalPresentationStyle = .fullScreen
            rootView?.present(joinViewController, animated: true)
        }
    }
    
    private func createTeam() {
        let rootView = presentingViewController
        dismiss(animated: true) {
            let createTeamViewController = UINavigationController(rootViewController: CreateTeamViewController())
            createTeamViewController.modalPresentationStyle = .fullScreen
            rootView?.present(createTeamViewController, animated: true)
        }
    }
    
    private func logout() {
        self.logoutUser()
    }
    
    private func withdrawal() {
        self.makeRequestAlert(title: TextLiteral.myReflectionViewControllerDeleteUserAlertTitle,
                              message: TextLiteral.myReflectionViewControllerDeleteUserAlertMessage,
                              okAction: { [weak self] _ in
            self?.deleteUser(type: .deleteUser)
        })
    }
    
    private func logoutUser() {
        makeRequestAlert(title: TextLiteral.myReflectionViewControllerLogOutMessage,
                         message: "",
                         okTitle: "확인",
                         cancelTitle: "취소") { _ in
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate
                    as? SceneDelegate else { return }
            sceneDelegate.logout()
        }
    }
    
    // MARK: - api
    
    private func fetchUserTeamList(type: TeamInfoEndPoint<VoidModel>) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<[TeamInfoResponse]>.self) { json in
            if let json = json.value {
                guard let teamCount = json.detail?.count else { return }
                self.teamCount = teamCount
                guard let team = json.detail else { return }
                self.changeTeamView.teamDataDummy = team
                self.setCurrentTeam()
            }
        }
    }
    
    private func deleteUser(type: MyReflectionEndPoint<VoidModel>) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers
        )
        .responseDecodable(of: BaseModel<VoidModel>.self) { json in
            if let _ = json.value {
                UserDefaultHandler.clearAllData()
                guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate
                        as? SceneDelegate else { return }
                sceneDelegate.logout()
            }
        }
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
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: TeamManageSettingFooterView.className) as? TeamManageSettingFooterView else { return UITableViewHeaderFooterView()
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

extension TeamManageViewController: ChangeTeamViewDelegate {
    func changeTeam(teamId: Int) {
        NotificationCenter.default.post(name: .chagneNotification, object: teamId)
        dismiss(animated: true)
    }
}
