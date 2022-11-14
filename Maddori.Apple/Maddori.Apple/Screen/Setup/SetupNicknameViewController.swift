//
//  SetupNicknameViewController.swift
//  Maddori.Apple
//
//  Created by LeeSungHo on 2022/10/20.
//

import UIKit

final class SetupNicknameViewController: BaseTextFieldViewController {
    
    override var titleText: String {
        get {
            return TextLiteral.setupNicknameViewControllerTitleLabel
        }
        set {
            super.titleText = newValue
        }
    }
    
    override var placeholderText: String {
        get {
            return TextLiteral.setupNicknameViewControllerNicknameTextFieldPlaceHolder
        }
        set {
            super.placeholderText = newValue
        }
    }
    
    override var maxLength: Int {
        get {
            return 6
        }
        
        set {
            super.maxLength = newValue
        }
    }
    
    override var buttonText: String {
        get {
            return TextLiteral.doneButtonTitle
        }
        set {
            super.buttonText = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pushJoinTeamViewController()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
    }
    
    // MARK: - func
    
    private func pushJoinTeamViewController() {
        let action = UIAction { [weak self] _ in
            self?.navigationController?.pushViewController(JoinTeamViewController(), animated: true)
        }
        super.doneButton.addAction(action, for: .touchUpInside)
    }
}
