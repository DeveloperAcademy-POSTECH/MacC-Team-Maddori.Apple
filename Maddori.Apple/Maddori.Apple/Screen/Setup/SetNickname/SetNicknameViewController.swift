//
//  SetupNicknameViewController.swift
//  Maddori.Apple
//
//  Created by LeeSungHo on 2022/10/20.
//

import UIKit
import PhotosUI

import Alamofire
import SnapKit

final class SetNicknameViewController: BaseViewController {
    
    enum ViewType {
        case createView
        case joinView
        case teamDetail
    }
    private enum TextLength {
        static let totalMin: Int = 0
        static let nicknameMax: Int = 6
        static let roleMax: Int = 20
    }
    private let cameraPicker = UIImagePickerController()
    var nickname: String?
    var role: String?
    var profilePath: String?
    private var profileURL: URL?
    private let fromView: ViewType
    private var teamId: Int?
    private let teamName: String
    
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
        button.title = TextLiteral.doneButtonTitle
        button.isDisabled = true
        let action = UIAction { [weak self] _ in
            self?.didTappedDoneButton()
            button.isLoading = true
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    
    init(from: ViewType, teamId: Int? = nil, teamName: String) {
        self.fromView = from
        self.teamId = teamId
        self.teamName = teamName
        super.init()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupEditProfile()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        setupNotificationCenter()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        doneButton.isLoading = false
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
        makeActionSheet(
            title: TextLiteral.setNicknameControllerProfileActionSheetTitle,
            actionTitles: [
                TextLiteral.setNicknameControllerProfileActionSheetLibraryTitle,
                TextLiteral.setNicknameControllerProfileActionSheetCameraTitle,
                TextLiteral.actionSheetCancelTitle
            ],
            actionStyle: [.default, .default, .cancel],
            actions: [{ _ in self.setupPhotoLibrary() }, { _ in self.openCamera() }, nil]
        )
    }
    
    private func setupDelegate() {
        nicknameTextField.delegate = self
        roleTextField.delegate = self
        cameraPicker.delegate = self
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
    
    private func openLibrary() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .any(of: [.images])
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        self.present(picker, animated: true, completion: nil)
    }
    
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            cameraPicker.sourceType = .camera
            self.present(cameraPicker, animated: false, completion: nil)
        } else {
            self.makeAlert(title: TextLiteral.setNicknameControllerCameraErrorAlertTitle, message: TextLiteral.setNicknameControllerCameraErrorAlertMessage)
        }
    }
    
    private func didTappedDoneButton() {
        guard let nickname = nicknameTextField.text else { return }
        guard let role = roleTextField.text else { return }
        
        switch fromView {
        case .createView:
            let dto = CreateTeamDTO(team_name: teamName, nickname: nickname, role: role)
            dispatchCreateTeam(type: .dispatchCreateTeam(dto))
        case .joinView:
            let dto = JoinTeamDTO(nickname: nickname, role: role)
            dispatchJoinTeam(type: .dispatchJoinTeam(teamId: UserDefaultStorage.teamId, dto))
        case .teamDetail:
            let dto = JoinTeamDTO(nickname: nickname, role: role)
            patchEditProfile(type: .patchEditProfile(dto))
        }
        
        nicknameTextField.resignFirstResponder()
        roleTextField.resignFirstResponder()
    }
    
    private func pushInvitationCodeViewController(invitationCode: String) {
        let viewModel = InvitationCodeViewModel(invitationCode: invitationCode)
        let viewController = InvitationCodeViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func setupPhotoLibrary() {
        switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
        case .limited, .authorized:
            openLibrary()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] status in
                switch status {
                case .limited, .authorized:
                    DispatchQueue.main.async {
                        self?.openLibrary()
                    }
                default:
                    self?.showPermissionAlert()
                }
            }
        case .restricted, .denied:
            showPermissionAlert()
        default:
            break
        }
    }
    
    private func showPermissionAlert() {
        DispatchQueue.main.async {
            guard let settingURL = URL(string: UIApplication.openSettingsURLString) else { return }
            self.makeAlert(title: TextLiteral.setNicknameViewControllerPermissionAlertTitle, message: TextLiteral.setNicknameViewControllerPermissionAlertMessage, okAction: { _ in
                UIApplication.shared.open(settingURL)
            })
        }
    }
    
    private func setupEditProfile() {
        if fromView == .teamDetail {
            navigationController?.isNavigationBarHidden = false
            self.tabBarController?.tabBar.isHidden = true
            
            nicknameTextField.text = nickname
            roleTextField.text = role
            if let profilePath {
                profileImageButton.profileImage.load(from: UrlLiteral.imageBaseURL + profilePath)
            }
        }
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
        AF.upload(multipartFormData: { multipartFormData in
            guard let teamName = type.body?.team_name,
                  let teamNameData = teamName.utf8Encode() else { return }
            multipartFormData.append(teamNameData, withName: "team_name")
            guard let nickname = type.body?.nickname,
                  let nicknameData = nickname.utf8Encode() else { return }
            multipartFormData.append(nicknameData, withName: "nickname")
            if let role = type.body?.role {
                guard let roleData = role.utf8Encode() else { return }
                multipartFormData.append(roleData, withName: "role")
            }
            if let profileURL = self.profileURL {
                multipartFormData.append(profileURL,
                                         withName: "profile_image",
                                         fileName: ".png",
                                         mimeType: "image/png")
            }
        }, to: type.address, method: type.method, headers: type.headers).responseDecodable(of: BaseModel<CreateTeamResponse>.self) { json in
            if let json = json.value {
                dump(json)
                guard let teamId = json.detail?.team?.id else { return }
                guard let nickname = json.detail?.nickname else { return }
                UserDefaultHandler.setTeamId(teamId: teamId)
                UserDefaultHandler.setNickname(nickname: nickname)
                UserDefaultHandler.setIsLogin(isLogin: true)
                DispatchQueue.main.async {
                    if let invitationCode = json.detail?.team?.invitationCode {
                        self.pushInvitationCodeViewController(invitationCode: invitationCode)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.makeAlert(title: TextLiteral.setNicknameViewControllerCreateTeamAlertTitle, message: TextLiteral.setNicknameViewControllerAlertMessage)
                    self.doneButton.isLoading = false
                }
            }
        }
    }
    
    private func dispatchJoinTeam(type: SetupEndPoint<JoinTeamDTO>) {
        AF.upload(multipartFormData: { multipartFormData in
            guard let nickname = type.body?.nickname,
                  let nicknameData = nickname.utf8Encode() else { return }
            multipartFormData.append(nicknameData, withName: "nickname")
            if let role = type.body?.role {
                guard let roleData = role.utf8Encode() else { return }
                multipartFormData.append(roleData, withName: "role")
            }
            if let profileURL = self.profileURL {
                multipartFormData.append(profileURL,
                                         withName: "profile_image",
                                         fileName: ".png",
                                         mimeType: "image/png")
            }
        }, to: type.address, method: type.method, headers: type.headers).responseDecodable(of: BaseModel<JoinTeamResponse>.self) { json in
            if let json = json.value {
                dump(json)
                guard let teamId = json.detail?.team?.id else { return }
                guard let nickname = json.detail?.nickname else { return }
                UserDefaultHandler.setTeamId(teamId: teamId)
                UserDefaultHandler.setNickname(nickname: nickname)
                UserDefaultHandler.setIsLogin(isLogin: true)
                DispatchQueue.main.async {
                    if let invitationCode = json.detail?.team?.invitationCode {
                        self.pushInvitationCodeViewController(invitationCode: invitationCode)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.makeAlert(title: TextLiteral.setNicknameViewControllerJoinTeamAlertTitle, message: TextLiteral.setNicknameViewControllerAlertMessage)
                    self.doneButton.isLoading = false
                }
            }
        }
    }
    
    private func patchEditProfile(type: TeamDetailEndPoint<JoinTeamDTO>) {
        AF.upload(multipartFormData: { multipartFormData in
            guard let nickname = type.body?.nickname,
                  let nicknameData = nickname.utf8Encode() else { return }
            multipartFormData.append(nicknameData, withName: "nickname")
            if let role = type.body?.role {
                guard let roleData = role.utf8Encode() else { return }
                multipartFormData.append(roleData, withName: "role")
            }
            if let profileURL = self.profileURL {
                multipartFormData.append(profileURL,
                                         withName: "profile_image",
                                         fileName: ".png",
                                         mimeType: "image/png")
            }
        }, to: type.address, method: type.method, headers: type.headers).responseDecodable(of: BaseModel<MemberDetailResponse>.self) { json in
            if let json = json.value {
                dump(json)
                guard let nickname = json.detail?.nickname else { return }
                UserDefaultHandler.setNickname(nickname: nickname)
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                    self.doneButton.isLoading = false
                }
            } else {
                DispatchQueue.main.async {
                    self.makeAlert(title: TextLiteral.setNicknameViewControllerEditProfileAlertTitle, message: TextLiteral.setNicknameViewControllerAlertMessage)
                    self.doneButton.isLoading = false
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
            if textField.text != nickname {
                let hasText = textField.hasText
                doneButton.isDisabled = !hasText
            } else {
                doneButton.isDisabled = true
            }
        } else if textField == roleTextField {
            if fromView == .teamDetail && textField.text != role && nicknameTextField.hasText {
                doneButton.isDisabled = false
            }
        }
    }
}

extension SetNicknameViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                guard let profileImage = image as? UIImage else { return }
                DispatchQueue.main.async {
                    self.profileImageButton.profileImage.image = profileImage.fixOrientation()
                }
                if let data = profileImage.fixOrientation().pngData() {
                    let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                    let url = documents.appendingPathComponent(".png")
                    do {
                        try data.write(to: url)
                        self.profileURL = url
                        DispatchQueue.main.async {
                            if url != URL(string: self.profilePath ?? "") && self.nicknameTextField.hasText {
                                self.doneButton.isDisabled = false
                            }
                        }
                    } catch {
                        self.makeAlert(title: TextLiteral.setNicknameControllerLibraryErrorAlertTitle, message: TextLiteral.setNicknameControllerLibraryErrorAlertMessage)
                    }
                }
            }
        } else {
            self.makeAlert(title: TextLiteral.setNicknameControllerLibraryErrorAlertTitle, message: TextLiteral.setNicknameControllerLibraryErrorAlertMessage)
        }
    }
}

extension SetNicknameViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        cameraPicker.dismiss(animated: true)
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            DispatchQueue.main.async {
                self.profileImageButton.profileImage.image = image.fixOrientation()
            }
            if let data = image.fixOrientation().pngData() {
                let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let url = documents.appendingPathComponent(".png")
                do {
                    try data.write(to: url)
                    self.profileURL = url
                    if url != URL(string: self.profilePath ?? "") && self.nicknameTextField.hasText {
                        DispatchQueue.main.async {
                            self.doneButton.isDisabled = false
                        }
                    }
                } catch {
                    self.makeAlert(title: TextLiteral.setNicknameViewControllerCameraAlertTitle, message: TextLiteral.setNicknameViewControllerAlertMessage)
                }
            } else {
                self.makeAlert(title: TextLiteral.setNicknameViewControllerCameraAlertTitle, message: TextLiteral.setNicknameViewControllerAlertMessage)
            }
        }
    }
}
