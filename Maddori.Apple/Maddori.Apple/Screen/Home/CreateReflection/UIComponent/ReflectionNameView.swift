//
//  ReflectionNameView.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/18.
//

import UIKit

import SnapKit

final class ReflectionNameView: UIView {
    let maxLength = 15
    
    // MARK: - property
    
    private let reflectionNameLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.createReflectionViewControllerName
        label.font = .label2
        label.textColor = .black100
        return label
    }()
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.backgroundColor = .white300
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray100.cgColor
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 10
        textField.becomeFirstResponder()
        textField.setLeftPadding()
        textField.placeholder = TextLiteral.createReflectionViewControllerTextFieldPlaceHolder
        textField.font = .body1
        textField.textColor = .black100
        return textField
    }()
    private lazy var countTextLabel: UILabel = {
        let label = UILabel()
        label.text = "0/\(maxLength)"
        label.font = .body2
        label.textColor = .gray500
        return label
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
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
        
        self.addSubview(countTextLabel)
        countTextLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalTo(nameTextField.snp.bottom).offset(8)
        }
    }
    
    // MARK: - func
    
    private func setCountTextLabel(_ num: String) {
        countTextLabel.text = "\(num)/\(self.maxLength)"
    }
}

// MARK: - extension

extension ReflectionNameView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text {
            if text.count <= 15 {
                setCountTextLabel(text.count.description)
            } else {
                let endIndex = text.index(text.startIndex, offsetBy: 15)
                let fixedText = text[text.startIndex..<endIndex]
                textField.text = fixedText + " "
                
                DispatchQueue.main.async {
                    self.nameTextField.text = String(fixedText)
                }
            }
        }
    }
}
