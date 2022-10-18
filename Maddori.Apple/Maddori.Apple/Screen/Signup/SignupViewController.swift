//
//  SignupViewController.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2022/10/18.
//

import UIKit

import SnapKit

final class SignupViewController: BaseViewController {
    
    private let minLength: Int = 0
    private let maxLength: Int = 6
    private var nickname: String = ""
    
    // MARK: - property
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "키고에서 사용할 \n닉네임을 입력해주세요"
        label.font = .title
        label.numberOfLines = 2
        return label
    }()
    private let nicknameTextField: KigoTextField = {
        let textField = KigoTextField()
        textField.inText = "예) 진저, 호야, 성민"
        return textField
    }()
    private lazy var textLimitLabel: UILabel = {
        let label = UILabel()
        label.text = "\(minLength)/\(maxLength)"
        label.font = .body2
        label.textColor = .gray500
        return label
    }()
    private let doneButton: MainButton = {
        let button = MainButton()
        button.title = "입력완료"
        button.isDisabled = true
        return button
    }()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        render()
        setupNotificationCenter()
        setupDelegate()
    }
    
    override func configUI() {
        super.configUI()
    }
    
    override func render() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.leadingTrailingPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(nicknameTextField)
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(39)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(textLimitLabel)
        textLimitLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(4)
            $0.trailing.equalToSuperview().inset(27)
        }
        
        view.addSubview(doneButton)
        doneButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    // MARK: - function
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupDelegate() {
        nicknameTextField.delegate = self
    }
    
    override func endEditingView() {
        if !doneButton.isTouchInside {
            view.endEditing(true)
        }
    }
    
    private func setCounter(count: Int) {
        if count <= maxLength {
            textLimitLabel.text = "\(count)/\(maxLength)"
        }
        else {
            textLimitLabel.text = "\(maxLength)/\(maxLength)"
        }
    }
    
    private func checkMaxLength(textField: UITextField, maxLength: Int) {
        if let text = textField.text {
            if text.count > maxLength {
                let endIndex = text.index(text.startIndex, offsetBy: maxLength)
                let fixedText = text[text.startIndex..<endIndex]
                textField.text = fixedText + " "
                
                let when = DispatchTime.now()
                DispatchQueue.main.asyncAfter(deadline: when) {
                    self.nicknameTextField.text = String(fixedText)
                    self.setCounter(count: textField.text?.count ?? 0)
                }
            }
        }
    }
    
    // MARK: - selector
    @objc private func keyboardWillShow(notification:NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.doneButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 30)
            })
        }
    }
    
    @objc private func keyboardWillHide(notification:NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.doneButton.transform = .identity
        })
    }
}

// MARK: - Extension
extension SignupViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        setCounter(count: textField.text?.count ?? 0)
        checkMaxLength(textField: nicknameTextField, maxLength: maxLength)
        
        let hasText = nicknameTextField.hasText
        doneButton.isDisabled = !hasText
    }
}
