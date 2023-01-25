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
        button.setTitle("편집", for: .normal)
        button.titleLabel?.font = .label2
        button.setTitleColor(.gray500, for: .normal)
        button.setUnderline()
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEditButton()
    }
    
    override func configUI() {
        super.configUI()
        navigationController?.isNavigationBarHidden = false
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
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let button = removeBarButtonItemOffset(with: backButton, offsetX: 10)
        let backButton = makeBarButtonItem(with: button)
        
        navigationItem.leftBarButtonItem = backButton
    }
    
    // MARK: - func
    
    private func setupEditButton() {
        let action = UIAction { _ in
            // FIXME: - 방 정보 수정 view 연결
            print("action")
        }
        self.editButton.addAction(action, for: .touchUpInside)
    }
}
