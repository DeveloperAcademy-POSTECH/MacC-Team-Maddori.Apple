//
//  SignupViewController.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2022/10/18.
//

import UIKit

import SnapKit

final class SignupViewController: BaseViewController {
    
    private let minNum: Int = 0
    private let maxNum: Int = 6
    
    // MARK: - property
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "키고에서 사용할 \n닉네임을 입력해주세요"
        label.font = .title
        label.numberOfLines = 2
        return label
    }()
    
    private let nicknameTextField: UITextField = {
        let textField = UITextField()
        let attributes = [
            NSAttributedString.Key.font : UIFont.body1,
            NSAttributedString.Key.foregroundColor : UIColor.gray500
        ]
        textField.backgroundColor = .white300
        textField.attributedPlaceholder = NSAttributedString(string: "예) 진저, 호야, 성민", attributes: attributes)
        textField.font = .body1
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.white300.cgColor
        textField.textAlignment = .left
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    private lazy var textLimitLabel: UILabel = {
        let label = UILabel()
        label.text = "\(minNum)/\(maxNum)"
        label.font = .body2
        label.textColor = .gray500
        return label
    }()
    
    private let doneButton: MainButton = {
        let button = MainButton()
        button.title = "입력완료"
        return button
    }()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        render()
    }
    
    override func configUI() {
        super.configUI()
    }
    
    override func render() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(Size.topPadding)
            $0.leading.equalToSuperview().inset(Size.leadingTrailingPadding)
        }
        
        view.addSubview(nicknameTextField)
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(39)
            $0.leading.trailing.equalToSuperview().inset(Size.leadingTrailingPadding)
            $0.height.equalTo(56)
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
    
    // MARK: - selector
}


enum Size {
    static let leadingTrailingPadding: Int = 24
    static let topPadding: Int = 20
}
