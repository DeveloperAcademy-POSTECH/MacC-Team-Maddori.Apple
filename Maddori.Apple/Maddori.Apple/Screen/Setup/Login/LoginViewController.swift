//
//  LoginViewController.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/06.
//

import AuthenticationServices
import UIKit

import Alamofire
import SnapKit

final class LoginViewController: BaseViewController {
    
    // MARK: - property
    
    private let keygoLogoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.imgKeygoLogo
        return imageView
    }()
    private let keygoLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.loginViewControllerLogoText
        label.font = .font(.bold, ofSize: 25)
        return label
    }()
    private let keygoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.loginViewControllerDescriptionText
        label.font = .font(.bold, ofSize: 18)
        return label
    }()
    private lazy var appleLoginButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        let action = UIAction { [weak self] _ in
            // FIXME: - 로그인 API연결
//            self?.presentSetupNickNameViewController()
            // FIXME: - AppleLogin 연결 후, 성공했을 때로 옮겨야 함.
//            self?.setLoginUserDefaults()
            self?.appleSignIn()
        }
        button.cornerRadius = 15
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    
    override func configUI() {
        super.configUI()
        setGradientText()
    }
    
    override func render() {
        view.addSubview(keygoLogoImage)
        keygoLogoImage.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-40)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(keygoLabel)
        keygoLabel.snp.makeConstraints {
            $0.top.equalTo(keygoLogoImage.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(keygoDescriptionLabel)
        keygoDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(keygoLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(appleLoginButton)
        appleLoginButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(2)
            $0.height.equalTo(54)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
    }
    
    // MARK: - func
    
    private func setGradientText() {
        keygoLabel.layoutIfNeeded()
        keygoLabel.setTextGradientColorTopToBottom(bound: keygoLabel.bounds)
        
        keygoDescriptionLabel.layoutIfNeeded()
        keygoDescriptionLabel.setTextGradientColorTopToBottom(bound: keygoDescriptionLabel.bounds)
    }
    
    private func appleSignIn() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    private func presentSetupNickNameViewController() {
        let viewController = SetNicknameViewController()
        viewController.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func setLoginUserDefaults() {
        UserDefaultHandler.setIsLogin(isLogin: true)
    }
    
    // MARK: - api
    
    private func dispatchAppleLogin(type: SetupEndPoint<AppleLoginDTO>) {
        AF.request(type.address,
                   method: type.method,
                   parameters: type.body,
                   encoder: JSONParameterEncoder.default,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<AppleLoginResponse>.self) { [weak self] json in
            if let data = json.value {
                dump(data)
                self?.presentSetupNickNameViewController()
            }
        }
    }
}

    // MARK: - extension

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            let userIdentifier = appleIDCredential.user
            
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: userIdentifier) { (credentialState, error) in
                switch credentialState {
                case .authorized:
                    // The Apple ID credential is valid. Show Home UI Here
                    guard let token = appleIDCredential.identityToken else { return }
                    guard let tokenToString = String(data: token, encoding: .utf8) else { return }
                    let dto = AppleLoginDTO(token: tokenToString)
                    self.dispatchAppleLogin(type: .dispatchAppleLogin(dto))
                    break
                case .revoked:
                    // The Apple ID credential is revoked. Show SignIn UI Here.
                    print("revoked")
                    break
                case .notFound:
                    // No credential was found. Show SignIn UI Here.
                    print("notFound")
                    break
                default:
                    break
                }
            }
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error)
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
