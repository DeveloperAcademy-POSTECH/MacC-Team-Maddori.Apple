//
//  SetupNicknameViewController.swift
//  Maddori.Apple
//
//  Created by LeeSungHo on 2022/10/20.
//

import UIKit

import Alamofire
import SnapKit

final class SetNicknameViewController: BaseViewController {
    
    var teamName = "맛쟁이사과처럼세글자"
    private let minLength: Int = 0
    
    enum maxTextLength: Int {
        case nickname = 15
        case role = 20
    }
    
    // MARK: - property
    
    private lazy var backButton: BackButton = {
        let button = BackButton()
        let action = UIAction { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = teamName + "에서\n사용할 프로필을 작성해 주세요"
        label.font = .title
        label.textColor = .black100
        label.numberOfLines = 0
        label.setLineSpacingWithColorApplied(amount: 4, colorTo: teamName, with: .blue200)
        return label
    }()
    private lazy var profileImageButton: ProfileImageButton = {
        let button = ProfileImageButton()
        let action = UIAction { [weak self] _ in
            self?.didTappedProfile()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임 *"
        label.textColor = .black100
        label.font = .label2
        label.applyColor(to: "*", with: .red100)
        return label
    }()
    private let nicknameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeHolderText = "ex) 진저"
        return textField
    }()
    private lazy var nicknameTextLimitLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "\(minLength)/\(maxTextLength.nickname.rawValue)", lineHeight: 22)
        label.font = .body2
        label.textColor = .gray500
        return label
    }()
    private let roleLabel: UILabel = {
        let label = UILabel()
        label.text = "역할"
        label.textColor = .black100
        label.font = .label2
        return label
    }()
    private let roleTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeHolderText = "ex) iOS 개발자"
        return textField
    }()
    private lazy var roleTextLimitLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "\(minLength)/\(maxTextLength.role.rawValue)", lineHeight: 22)
        label.font = .body2
        label.textColor = .gray500
        return label
    }()
    private lazy var doneButton: MainButton = {
        let button = MainButton()
        button.title = "입력 완료"
        button.isDisabled = true
        let action = UIAction { [weak self] _ in
            //            guard let nickname = self?.kigoTextField.text else { return }
            //            self?.dispatchUserLogin(type: .dispatchLogin(LoginDTO(username: nickname)))
            //            self?.kigoTextField.resignFirstResponder()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNotificationCenter()
    }
    
    override func render() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(profileImageButton)
        profileImageButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(44)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(68)
        }
        
        view.addSubview(nicknameLabel)
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageButton.snp.bottom).offset(40)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(nicknameTextField)
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(SizeLiteral.labelComponentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(nicknameTextLimitLabel)
        nicknameTextLimitLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(4)
            $0.trailing.equalToSuperview().inset(27)
        }
        
        view.addSubview(roleLabel)
        roleLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(SizeLiteral.componentIntervalPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(roleTextField)
        roleTextField.snp.makeConstraints {
            $0.top.equalTo(roleLabel.snp.bottom).offset(SizeLiteral.labelComponentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(roleTextLimitLabel)
        roleTextLimitLabel.snp.makeConstraints {
            $0.top.equalTo(roleTextField.snp.bottom).offset(4)
            $0.trailing.equalToSuperview().inset(27)
        }
        
        view.addSubview(doneButton)
        doneButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(2)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let button = removeBarButtonItemOffset(with: backButton, offsetX: 10)
        let backButton = makeBarButtonItem(with: button)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // MARK: - func
    
    private func didTappedProfile() {
        // FIXME: - 갤러리로 이동
        print("프로필 누름")
    }
    
    private func setupDelegate() {
        nicknameTextField.delegate = self
        roleTextField.delegate = self
    }
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func endEditingView() {
        if !doneButton.isTouchInside {
            view.endEditing(true)
        }
    }
    
    private func setCounter(textField: UITextField, count: Int) {
        let maxLength = textField == nicknameTextField ? maxTextLength.nickname.rawValue : maxTextLength.role.rawValue
        let textLimitLabel = textField == nicknameTextField ? nicknameTextLimitLabel : roleTextLimitLabel
        if count <= maxLength {
            textLimitLabel.text = "\(count)/\(maxLength)"
        }
        else {
            textLimitLabel.text = "\(maxLength)/\(maxLength)"
        }
    }
    
    private func checkMaxLength(textField: UITextField) {
        let maxLength = textField == nicknameTextField ? maxTextLength.nickname.rawValue : maxTextLength.role.rawValue
        if let text = textField.text {
            if text.count > maxLength {
                let endIndex = text.index(text.startIndex, offsetBy: maxLength)
                let fixedText = text[text.startIndex..<endIndex]
                textField.text = fixedText + " "
                
                DispatchQueue.main.async {
                    textField.text = String(fixedText)
                }
            }
        }
    }
    
    // MARK: - selector
    
    @objc private func keyboardWillShow(notification:NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.doneButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 24)
            })
        }
    }
    
    @objc private func keyboardWillHide(notification:NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.doneButton.transform = .identity
        })
    }
    
    // MARK: - api
    
    //    private func dispatchUserLogin(type: SetupEndPoint<LoginDTO>) {
    //        AF.request(type.address,
    //                   method: type.method,
    //                   parameters: type.body,
    //                   encoder: JSONParameterEncoder.default,
    //                   headers: type.headers
    //        ).responseDecodable(of: BaseModel<JoinMemberResponse>.self) { [weak self] response in
    //            guard let self else { return }
    //            switch response.result {
    //            case .success:
    //                guard let nickname = self.kigoTextField.text else { return }
    //                UserDefaultHandler.setNickname(nickname: nickname)
    //                self.navigationController?.pushViewController(JoinTeamViewController(), animated: true)
    //            case .failure:
    //                self.makeAlert(title: TextLiteral.setNicknameViewControllerAlertTitle, message: TextLiteral.setNicknameControllerAlertMessage)
    //            }
    //        }
    //    }
}

// MARK: - Extension

extension SetNicknameViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        setCounter(textField: textField, count: textField.text?.count ?? 0)
        checkMaxLength(textField: textField)
        
        let hasText = textField.hasText
        doneButton.isDisabled = !hasText
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
