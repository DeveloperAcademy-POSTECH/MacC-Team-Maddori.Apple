//
//  CreateTeamViewController.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2022/10/22.
//

import UIKit

import SnapKit

final class CreateTeamViewController: BaseTextFieldViewController {
    
    override var titleText: String {
        get {
            return TextLiteral.createTeamViewControllerTitleLabel
        }
        
        set {
            super.titleText = newValue
        }
    }
    
    override var placeholderText: String {
        get {
            return TextLiteral.createTeamViewControllerTextFieldPlaceHolder
        }
        
        set {
            super.placeholderText = newValue
        }
    }
    
    override var buttonText: String {
        get {
            return TextLiteral.joinTeamViewControllerSubButtonText
        }
        
        set {
            super.buttonText = newValue
        }
    }
    
    override var maxLength: Int {
        get {
            return 10
        }
        
        set {
            super.maxLength = newValue
        }
    }
    
    // MARK: - property
    
    private lazy var closeButton: CloseButton = {
        let button = CloseButton()
        let action = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCreateButtonAction()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let closeButton = makeBarButtonItem(with: closeButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = closeButton
    }
    
    // MARK: - setup
    
    private func setupCreateButtonAction() {
        let action = UIAction { [weak self] _ in
            self?.pushHomeViewController()
        }
        super.doneButton.addAction(action, for: .touchUpInside)
    }
    
    // MARK: - func
    
    private func pushHomeViewController() {
        guard let parentViewController = presentingViewController as? UINavigationController else { return }
        dismiss(animated: true) {
            let rootViewController = UINavigationController(rootViewController: CustomTabBarController())
            rootViewController.modalPresentationStyle = .fullScreen
            rootViewController.modalTransitionStyle = .crossDissolve
            parentViewController.present(rootViewController, animated: true)
        }
    }
}
