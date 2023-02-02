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
        label.text = "멤버"
        label.textColor = .black100
        label.font = .label2
        return label
    }()
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 23
        imageView.image = ImageLiterals.imgDefaultProfile
        return imageView
    }()
    private let profileNicknameLabel: UILabel = {
        let label = UILabel()
        // FIXME: - API 연결 후 삭제
        label.text = "이두"
        label.font = .label2
        label.textColor = .gray600
        return label
    }()
    private let profileRoleLabel: UILabel = {
        let label = UILabel()
        // FIXME: - API 연결 후 삭제
        label.text = "디자인 리드 / 개발자"
        label.font = .caption2
        label.textColor = .gray400
        return label
    }()
    private let dividerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.gray300.cgColor
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
        
        view.addSubview(profileImageView)
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(memberTitleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.width.height.equalTo(46)
        }
        
        view.addSubview(profileNicknameLabel)
        profileNicknameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(12)
            $0.bottom.equalTo(profileImageView.snp.centerY)
        }
        
        view.addSubview(profileRoleLabel)
        profileRoleLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(12)
            $0.top.equalTo(profileNicknameLabel.snp.bottom).offset(4)
        }
        
        view.addSubview(dividerView)
        dividerView.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(1)
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
