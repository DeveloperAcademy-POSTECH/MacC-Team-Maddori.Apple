//
//  TeamDetailViewController.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2023/01/25.
//

import UIKit

import Alamofire
import SnapKit

final class TeamDetailViewController: BaseViewController {
    private var invitationCode: String?
    
    // MARK: - property
    
    private lazy var backButton = BackButton(type: .system)
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .title
        label.textColor = .black100
        label.text = UserDefaultStorage.teamName
        return label
    }()
    private let editButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextLiteral.teamDetailViewControllerEditButteonText, for: .normal)
        button.titleLabel?.font = .label2
        button.setTitleColor(.gray500, for: .normal)
        button.setUnderline()
        return button
    }()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let memberTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.teamDetailViewControllerMemberTitleLabel
        label.textColor = .black100
        label.font = .label2
        return label
    }()
    private let memberTableView = TeamDetailMembersView()
    private let firstFullDividerView = FullDividerView()
    private let codeShareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(TextLiteral.teamDetailViewControllerShareCodeText, for: .normal)
        button.setTitleColor(.blue200, for: .normal)
        button.titleLabel?.font = .label2
        return button
    }()
    private let invitationCodeLabel: UILabel = {
        let label = UILabel()
        label.font = .label2
        label.textColor = .gray600
        return label
    }()
    private let secondFullDividerView = FullDividerView()
    private let teamLeaveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(TextLiteral.teamDetailViewControllerLeaveTeamLabel, for: .normal)
        button.titleLabel?.font = .label2
        button.setTitleColor(.red100, for: .normal)
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        setupBackButton()
        setupEditButton()
        setupExitButton()
        setupCodeShareButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchTeamDetailMember(type: .fetchTeamMember)
        fetchTeamInformation(type: .fetchTeamInformation)
    }
    
    override func render() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(editButton)
        editButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.width.height.equalTo(44)
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(SizeLiteral.topComponentPadding)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(view.snp.width)
            $0.height.equalTo(view.snp.height).priority(.low)
        }

        contentView.addSubview(memberTitleLabel)
        memberTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(16)
        }

        contentView.addSubview(memberTableView)
        memberTableView.snp.makeConstraints {
            $0.top.equalTo(memberTitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(calculateHeight())
        }
        
        contentView.addSubview(firstFullDividerView)
        firstFullDividerView.snp.makeConstraints {
            $0.top.equalTo(memberTableView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(4)
        }
        
        contentView.addSubview(codeShareButton)
        codeShareButton.snp.makeConstraints {
            $0.top.equalTo(firstFullDividerView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }

        contentView.addSubview(invitationCodeLabel)
        invitationCodeLabel.snp.makeConstraints {
            $0.centerY.equalTo(codeShareButton.snp.centerY)
            $0.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }

        contentView.addSubview(secondFullDividerView)
        secondFullDividerView.snp.makeConstraints {
            $0.top.equalTo(invitationCodeLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(4)
        }

        contentView.addSubview(teamLeaveButton)
        teamLeaveButton.snp.makeConstraints {
            $0.top.equalTo(secondFullDividerView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let button = removeBarButtonItemOffset(with: backButton, offsetX: 10)
        let backButton = makeBarButtonItem(with: button)
        
        navigationItem.leftBarButtonItem = backButton
    }
    
    // MARK: - func
    
    private func setupBackButton() {
        let action = UIAction { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        backButton.addAction(action, for: .touchUpInside)
    }
    
    private func setupEditButton() {
        let action = UIAction { [weak self] _ in
            let viewController = EditTeamNameViewController()
            viewController.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
        self.editButton.addAction(action, for: .touchUpInside)
    }
    
    private func setupExitButton() {
        let action = UIAction { [weak self] _ in
            self?.makeRequestAlert(title: TextLiteral.teamDetailViewControllerLeaveTeamAlertTitle,
                                   message: TextLiteral.teamDetailViewControllerLeaveTeamAlertMessage,
                                   okTitle: TextLiteral.leaveTitle,
                                   okAction: { _ in
                self?.deleteLeaveTeam(type: .deleteTeam)
            })
        }
        teamLeaveButton.addAction(action, for: .touchUpInside)
    }
    
    private func setupCodeShareButton() {
        let action = UIAction { [weak self] _ in
            UIPasteboard.general.string = self?.invitationCode
        }
        codeShareButton.addAction(action, for: .touchUpInside)
    }
    
    private func updateLayout() {
        memberTableView.snp.updateConstraints {
            $0.height.equalTo(calculateHeight())
        }
    }
    
    // MARK: - api
    
    private func fetchTeamDetailMember(type: TeamDetailEndPoint<VoidModel>) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers).responseDecodable(of: BaseModel<TeamMembersResponse>.self) { json in
            if let data = json.value {
                guard let members = data.detail?.members else { return }
                DispatchQueue.main.async {
                    self.memberTableView.loadData(data: members)
                    self.updateLayout()
                }
            }
        }
    }
    
    private func fetchTeamInformation(type: TeamDetailEndPoint<VoidModel>) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers).responseDecodable(of: BaseModel<CertainTeamDetailResponse>.self) { json in
            if let data = json.value {
                guard let teamName = data.detail?.teamName,
                      let invitationCode = data.detail?.invitationCode
                else { return }
                self.invitationCode = invitationCode
                DispatchQueue.main.async {
                    self.invitationCodeLabel.text = invitationCode
                    self.titleLabel.text = teamName
                }
                UserDefaultHandler.setTeamName(teamName: teamName)
            }
        }
    }
    
    private func deleteLeaveTeam(type: TeamDetailEndPoint<VoidModel>) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers).responseDecodable(of: BaseModel<VoidModel>.self) { json in
            if let _ = json.value {
                self.fetchUserTeamList(type: .fetchUserTeamList) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    private func fetchUserTeamList(type: TeamDetailEndPoint<VoidModel>, completion: @escaping (() ->())) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers).responseDecodable(of: BaseModel<[TeamInfoResponse]>.self) { json in
            if let data = json.value {
                guard let teams = data.detail else { return }
                if !teams.isEmpty {
                    guard let teamId = teams.first?.id else { return }
                    UserDefaultHandler.setTeamId(teamId: teamId)
                } else {
                    UserDefaultHandler.setTeamId(teamId: 0)
                }
                completion()
            }
        }
    }
    
    private func calculateHeight() -> CGFloat {
        let size = TeamDetailMembersView.PropertySize.self
        let hasHomeIndicator = UIScreen.main.bounds.width * 2 < UIScreen.main.bounds.height
        let bottomInset: CGFloat = hasHomeIndicator ? 34 : 0
        let minHeight = view.frame.size.height - statusBarHeight - size.navigationBarHeight - size.tableViewTopProperty - size.tableViewBottomProperty - bottomInset - 60
        let currentHeight = (size.cellSize + size.cellSpacing) * CGFloat(memberTableView.members.count) + size.headerViewHeight + size.cellSpacing
        let height = max(minHeight, currentHeight)
        return height
    }
}
