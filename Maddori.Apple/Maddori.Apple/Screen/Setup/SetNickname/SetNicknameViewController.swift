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
            self?.dispatchUserLogin(api: .dispatchlogin(LoginDTO(username: nickname)))
        }
        super.doneButton.addAction(action, for: .touchUpInside)
    }
    
    // MARK: - api
    
    private func dispatchUserLogin(api: SetupEndPoint<LoginDTO>) {
        AF.request(api.address,
                   method: api.method,
                   parameters: api.body,
                   encoder: JSONParameterEncoder.default
        ).responseDecodable(of: BaseModel<MemberResponse>.self) { json in
            if let json = json.value {
                dump(json)
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(JoinTeamViewController(), animated: true)
                }
            } else {
                DispatchQueue.main.async {
                    // FIXME: - UXWriting 필요
                    self.makeAlert(title: "에러", message: "중복된 닉네임입니다람쥐")
                }
            }
        }
    }
}
