//
//  FromToViewController.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/10/25.
//

import UIKit

import SnapKit

final class FromToViewController: BaseViewController {

    private let fromTextFieldTag = 0
    private let toTextFieldTag = 1
    
    // MARK: - properties
    
    private let exitButton = ExitButton(type: .system)
    private let fromToTitle: UILabel = {
        let label = UILabel()
        label.setTitleFont(text: "피드백 줄 사람을\n입력해주세요")
        label.textColor = .black100
        label.numberOfLines = 0
        return label
    }()
    private let subTitle: UILabel = {
        let label = UILabel()
        label.text = "이 페이지는 TestFlight에서만 사용됩니다"
        label.font = .caption1
        label.textColor = .gray400
        return label
    }()
    private let fromLabel: UILabel = {
        let label = UILabel()
        label.text = "From"
        label.font = .label2
        label.textColor = .black100
        return label
    }()
    private lazy var fromTextField: KigoTextField = {
        let textField = KigoTextField()
        textField.placeHolderText = "본인 닉네임을 입력해주세요"
        textField.returnKeyType = .done
        textField.tag = fromTextFieldTag
        return textField
    }()
    private let toLabel: UILabel = {
        let label = UILabel()
        label.text = "To"
        label.font = .label2
        label.textColor = .black100
        return label
    }()
    private lazy var toTextField: KigoTextField = {
        let textField = KigoTextField()
        textField.placeHolderText = "받는 사람 닉네임을 입력해주세요"
        textField.tag = toTextFieldTag
        return textField
    }()
    private let nextButton: MainButton = {
        let button = MainButton()
        button.title = "다음"
        button.isDisabled = true
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotificationCenter()
        setupDelegation()
    }
    
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let exitButton = makeBarButtonItem(with: exitButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = exitButton
    }
    
    override func render() {
        view.addSubview(fromToTitle)
        fromToTitle.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(subTitle)
        subTitle.snp.makeConstraints {
            $0.top.equalTo(fromToTitle.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view?.addSubview(fromLabel)
        fromLabel.snp.makeConstraints {
            $0.top.equalTo(subTitle.snp.bottom).offset(SizeLiteral.topComponentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(fromTextField)
        fromTextField.snp.makeConstraints {
            $0.top.equalTo(fromLabel.snp.bottom).offset(SizeLiteral.labelComponentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(toLabel)
        toLabel.snp.makeConstraints {
            $0.top.equalTo(fromTextField.snp.bottom).offset(SizeLiteral.componentIntervalPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(toTextField)
        toTextField.snp.makeConstraints {
            $0.top.equalTo(toLabel.snp.bottom).offset(SizeLiteral.labelComponentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.bottomPadding)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupDelegation() {
        fromTextField.delegate = self
        toTextField.delegate = self
    }
    
    // MARK: - selector
    
    @objc private func keyboardWillShow(notification:NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.nextButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 10)
            })
        }
    }
    
    @objc private func keyboardWillHide(notification:NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.nextButton.transform = .identity
        })
    }
}

extension FromToViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fromTextField {
            toTextField.becomeFirstResponder()
        } else {
            toTextField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let hasFromText = fromTextField.hasText
        let hasToText = toTextField.hasText
        nextButton.isDisabled = !(hasFromText && hasToText)
    }
}
