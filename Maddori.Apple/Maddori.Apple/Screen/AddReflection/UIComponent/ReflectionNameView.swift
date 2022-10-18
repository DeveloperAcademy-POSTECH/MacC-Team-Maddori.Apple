//
//  ReflectionNameView.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/18.
//

import UIKit

import SnapKit

final class ReflectionNameView: UIView {
    
    // MARK: - property
    
    private let reflectionNameLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.addReflectionViewControllerName
        label.font = .label2
        label.textColor = .black100
        return label
    }()
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white300
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray100.cgColor
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 10
        textField.becomeFirstResponder()
        textField.setLeftPadding()
        textField.placeholder = TextLiteral.addReflectionViewControllerTextFieldPlaceHolder
        textField.font = .body1
        // FIXME: - 텍스트필드의 글자색이 피그마에 없음
        textField.textColor = .black100
        return textField
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render() {
        self.addSubview(reflectionNameLabel)
        reflectionNameLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        
        self.addSubview(nameTextField)
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(reflectionNameLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(53)
        }
    }
}
