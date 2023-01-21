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
    private lazy var profileImageButton: UIButton = {
       let button = UIButton()
        button.setBackgroundImage(ImageLiterals.imgProfileNone, for: .normal)
        let action = UIAction { [weak self] _ in
            self?.didTappedProfile()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    
    override func render() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(profileImageButton)
        profileImageButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(44)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(68)
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
    
    //    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    //        return false
    //    }
    
    // MARK: - func
    
    private func didTappedProfile() {
        // FIXME: - 갤러리로 이동
        print("프로필 누름")
    }
    
    //    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //        textField.resignFirstResponder()
    //        return true
    //    }
    
    //    private func setupDoneButton() {
    //        let action = UIAction { [weak self] _ in
    //            guard let nickname = self?.kigoTextField.text else { return }
    //            self?.dispatchUserLogin(type: .dispatchLogin(LoginDTO(username: nickname)))
    //            self?.kigoTextField.resignFirstResponder()
    //        }
    //        super.doneButton.addAction(action, for: .touchUpInside)
    //    }
    
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
