//
//  TeamDetailViewController.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2023/01/25.
//

import UIKit

import SnapKit

final class TeamDetailViewController: BaseViewController {
    
    // MARK: - property
    
    private lazy var backButton = BackButton(type: .system)
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .title
        label.textColor = .black100
        // FIXME: - API 연결 후 삭제
        label.text = "맛쟁이 사과처럼"
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
        // FIXME: - APi 연결 후 삭제
        label.text = "1BCDEF"
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
        setupBackButton()
        setupEditButton()
        setupExitButton()
    }
    
    override func configUI() {
        super.configUI()
        navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
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
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - func
    
    private func setupBackButton() {
        let action = UIAction { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        backButton.addAction(action, for: .touchUpInside)
    }
    
    private func setupEditButton() {
        let action = UIAction { _ in
            // FIXME: - 방 정보 수정 view 연결
            print("action")
        }
        self.editButton.addAction(action, for: .touchUpInside)
    }
    
    private func setupExitButton() {
        let action = UIAction { [weak self] _ in
            self?.makeRequestAlert(title: TextLiteral.teamDetailViewControllerLeaveTeamAlertTitle,
                                   message: TextLiteral.teamDetailViewControllerLeaveTeamAlertMessage,
                                   okTitle: TextLiteral.leaveTitle,
                                   // FIXME: - 팀 나가기 API 연결
                                   okAction: nil)
        }
        teamLeaveButton.addAction(action, for: .touchUpInside)
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
