//
//  SetupNicknameViewController.swift
//  Maddori.Apple
//
//  Created by LeeSungHo on 2022/10/20.
//

import UIKit

import Alamofire

final class SetNicknameViewController: BaseTextFieldViewController {
    
    override var titleText: String {
        get {
            return TextLiteral.setNicknameViewControllerTitleLabel
        }
        set {
            super.titleText = newValue
        }
    }
    
    override var placeholderText: String {
        get {
            return TextLiteral.setNicknameViewControllerNicknameTextFieldPlaceHolder
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
        setupDoneButton()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    // MARK: - func
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func setupDoneButton() {
        let action = UIAction { [weak self] _ in
            guard let nickname = self?.kigoTextField.text else { return }
            self?.dispatchUserLogin(type: .dispatchLogin(LoginDTO(username: nickname)))
            self?.kigoTextField.resignFirstResponder()
        }
        super.doneButton.addAction(action, for: .touchUpInside)
    }
    
    // MARK: - api
    
    private func dispatchUserLogin(type: SetupEndPoint<LoginDTO>) {
        AF.request(type.address,
                   method: type.method,
                   parameters: type.body,
                   encoder: JSONParameterEncoder.default,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<JoinMemberResponse>.self) { [weak self] response in
            guard let self else { return }
            switch response.result {
            case .success:
                guard let nickname = self.kigoTextField.text else { return }
                UserDefaultHandler.setNickname(nickname: nickname)
                self.navigationController?.pushViewController(JoinTeamViewController(), animated: true)
            case .failure:
                self.makeAlert(title: TextLiteral.setNicknameViewControllerAlertTitle, message: TextLiteral.setNicknameControllerAlertMessage)
            }
        }
    }
}
