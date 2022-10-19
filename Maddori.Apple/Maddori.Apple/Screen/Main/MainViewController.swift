//
//  MainViewController.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/14.
//

import UIKit

import SnapKit

final class MainViewController: BaseViewController {
    
    // MARK: - property
    
    private lazy var mainButton: MainButton = {
        let button = MainButton()
        let action = UIAction { [weak self] _ in
            self?.presentAddReflectionView()
        }
        button.title = "예시"
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configUI() {
        view.backgroundColor = .backgroundWhite
    }
    
    override func render() {
        view.addSubview(mainButton)
        mainButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - func
    
    private func presentAddReflectionView() {
        let viewController = UINavigationController(rootViewController: AddReflectionViewController())
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
}
