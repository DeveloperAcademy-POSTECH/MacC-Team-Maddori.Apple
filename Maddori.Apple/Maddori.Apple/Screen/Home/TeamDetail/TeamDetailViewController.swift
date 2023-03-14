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
    private let memberTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.teamDetailViewControllerMemberTitleLabel
        label.textColor = .black100
        label.font = .label2
        return label
    }()
    private let memberInformationView = MemberInformationView(nickname: "이드", role: "디자인 리드 / 개발자")
    private let dividerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.gray300.cgColor
        return view
    }()
    private let memberCollectionView = TeamDetailMembersView()
    private let fullDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray300
        return view
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
        setupEditButton()
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
        
        view.addSubview(memberTitleLabel)
        memberTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(SizeLiteral.topComponentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(memberInformationView)
        memberInformationView.snp.makeConstraints {
            $0.top.equalTo(memberTitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(46)
        }

        view.addSubview(dividerView)
        dividerView.snp.makeConstraints {
            $0.top.equalTo(memberInformationView.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(1)
        }
        
        view.addSubview(memberCollectionView)
        memberCollectionView.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(120)
        }
        
        view.addSubview(fullDividerView)
        fullDividerView.snp.makeConstraints {
            $0.top.equalTo(memberCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(4)
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
}
