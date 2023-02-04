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
    
    private enum TextLength {
        static let totalMin: Int = 0
        static let nicknameMax: Int = 6
        static let roleMax: Int = 20
    }
    
    let teamName: String = UserDefaultStorage.teamName
    
    // MARK: - property
    
    private lazy var backButton: BackButton = {
        let button = BackButton()
        let action = UIAction { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private let navigationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.setNicknameControllerNavigationTitleLabel
        label.textColor = .black100
        label.font = .label2
        return label
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = teamName + TextLiteral.setNicknameControllerTitleLabel
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
        label.text = TextLiteral.setNicknameControllerNicknameLabel
        label.textColor = .black100
        label.font = .label2
        label.applyColor(to: "*", with: .red100)
        return label
    }()
    private let nicknameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeHolderText = TextLiteral.setNicknameControllerNicknameTextFieldPlaceHolderText
        return textField
    }()
    private lazy var nicknameTextLimitLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "\(TextLength.totalMin)/\(TextLength.nicknameMax)", lineHeight: 22)
        label.font = .body2
        label.textColor = .gray500
        return label
    }()
    private let roleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.setNicknameControllerRoleLabel
        label.textColor = .black100
        label.font = .label2
        return label
    }()
    private let roleTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeHolderText = TextLiteral.setNicknameControllerRoleTextFieldPlaceHolderText
        return textField
    }()
    private lazy var roleTextLimitLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "\(TextLength.totalMin)/\(TextLength.roleMax)", lineHeight: 22)
        label.font = .body2
        label.textColor = .gray500
        return label
    }()
    private lazy var doneButton: MainButton = {
        let button = MainButton()
        button.title = TextLiteral.setNicknameControllerDoneButtonText
        button.isDisabled = true
        let action = UIAction { [weak self] _ in
            self?.didTappedDoneButton()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
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
        
        navigationItem.titleView = navigationTitleLabel
        navigationItem.titleView?.isHidden = true
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
        let maxLength = textField == nicknameTextField ? TextLength.nicknameMax : TextLength.roleMax
        let textLimitLabel = textField == nicknameTextField ? nicknameTextLimitLabel : roleTextLimitLabel
        if count <= maxLength {
            textLimitLabel.text = "\(count)/\(maxLength)"
        }
    }
    
    private func checkMaxLength(textField: UITextField) {
        let maxLength = textField == nicknameTextField ? TextLength.nicknameMax : TextLength.roleMax
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
    
    private func didTappedTextField() {
        titleLabel.snp.updateConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(-100)
        }
        navigationItem.titleView?.isHidden = false
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func didTappedBackground() {
        titleLabel.snp.updateConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.topPadding)
        }
        navigationItem.titleView?.isHidden = true
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func didTappedDoneButton() {
        guard let nickname = nicknameTextField.text else { return }
        guard let role = roleTextField.text else { return }
        
        if UserDefaultStorage.teamId == 0 {
            let dto = CreateTeamDTO(team_name: UserDefaultStorage.teamName, nickname: nickname, role: role, profile_image: nil)
            dispatchCreateTeam(type: .dispatchCreateTeam(dto))
        } else {
            let dto = JoinTeamDTO(nickname: nickname, role: role, profile_image: nil)
            dispatchJoinTeam(type: .dispatchJoinTeam(teamId: UserDefaultStorage.teamId, dto))
        }
        
        nicknameTextField.resignFirstResponder()
        roleTextField.resignFirstResponder()
    }
    
    private func pushInvitationCodeViewController(invitationCode: String) {
        let viewController = InvitationCodeViewController(invitationCode: invitationCode)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - selector
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.doneButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 24)
            })
        }
        
        didTappedTextField()
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.doneButton.transform = .identity
        })
        
        didTappedBackground()
    }
    
    // MARK: - api
    
    private func dispatchCreateTeam(type: SetupEndPoint<CreateTeamDTO>) {
        AF.request(type.address,
                   method: type.method,
                   parameters: type.body,
                   encoder: JSONParameterEncoder.default,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<CreateTeamResponse>.self) { json in
            if let json = json.value {
                dump(json)
                guard let teamId = json.detail?.id else { return }
                UserDefaultHandler.setTeamId(teamId: teamId)
                DispatchQueue.main.async {
                    if let invitationCode = json.detail?.team?.invitationCode {
                        self.pushInvitationCodeViewController(invitationCode: invitationCode)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.makeAlert(title: "팀 생성 및 팀 합류 실패", message: "다시 시도해 주세요.")
                }
            }
        }
    }
    
    private func dispatchJoinTeam(type: SetupEndPoint<JoinTeamDTO>) {
        AF.request(type.address,
                   method: type.method,
                   parameters: type.body,
                   encoder: JSONParameterEncoder.default,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<JoinTeamResponse>.self) { json in
            if let json = json.value {
                dump(json)
                DispatchQueue.main.async {
                    if let invitationCode = json.detail?.team?.invitationCode {
                        self.pushInvitationCodeViewController(invitationCode: invitationCode)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.makeAlert(title: "팀 합류 실패", message: "다시 시도해 주세요.")
                }
            }
        }
    }
}

// MARK: - extension

extension SetNicknameViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        setCounter(textField: textField, count: textField.text?.count ?? 0)
        checkMaxLength(textField: textField)
        
        if textField == nicknameTextField {
            let hasText = textField.hasText
            doneButton.isDisabled = !hasText
        }
    }
}
