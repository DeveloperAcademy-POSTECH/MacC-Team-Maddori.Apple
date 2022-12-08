//
//  KeywordTextField.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/12/08.
//

import UIKit

import Alamofire
import SnapKit

final class KeywordTextField: UIView {
    
    private enum Length {
        static let keywordMaxLength: Int = 10
    }
    private enum Size {
        static let textFieldMaxCornerRadius: CGFloat = 25
        static let textFieldMinCornerRadius: CGFloat = 16
        static let textFieldHeight: CGFloat = 50
        static let textFieldXPadding: CGFloat = 16
        static let textFieldYPadding: CGFloat = 13
    }
    
    var textFieldWidth: CGFloat = 0
    var placeholder = TextLiteral.addFeedbackKeywordViewControllerPlaceholder
    var placeholderWidth: CGFloat {
        let placeholder = TextLiteral.addFeedbackKeywordViewControllerPlaceholder
        let fontAttributes = [NSAttributedString.Key.font: UIFont.main]
        let width = (placeholder as NSString).size(withAttributes: fontAttributes).width
        return width
    }
    
    // MARK: - property
    
    let textFieldContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white100
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.layer.cornerRadius = Size.textFieldMaxCornerRadius
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowOpacity = 0.13
        view.layer.shadowRadius = 4
        return view
    }()
    lazy var keywordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.gray300,
                NSAttributedString.Key.font: UIFont.main
            ]
        )
        textField.textColor = .gray600
        return textField
    }()
    let keywordLimitLabel: UILabel = {
        let label = UILabel()
        label.font = .caption3
        label.textColor = .red100
        label.text = TextLiteral.keywordLimitLabel
        label.isHidden = true
        return label
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        setupDelegate()
        setupTextFieldObserver()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func render() {
        self.addSubview(textFieldContainerView)
        textFieldContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(placeholderWidth + 2 * Size.textFieldXPadding)
            $0.height.equalTo(Size.textFieldHeight)
        }

        self.addSubview(keywordTextField)
        keywordTextField.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(Size.textFieldXPadding)
        }
        
        self.addSubview(keywordLimitLabel)
        keywordLimitLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(textFieldContainerView.snp.bottom).offset(8)
        }
    }
    
    // MARK: - func
    
    private func setupDelegate() {
        keywordTextField.delegate = self
    }
    
    private func setupTextFieldObserver() {
        keywordTextField.addTarget(self, action: #selector(textFieldChangeBegin), for: .editingDidBegin)
        keywordTextField.addTarget(self, action: #selector(textFieldChanging), for: .allEditingEvents)
        keywordTextField.addTarget(self, action: #selector(textFieldChangeEnd), for: .editingDidEnd)
    }
    
    private func checkMaxLength(textField: UITextField, maxLength: Int) {
        if let text = textField.text {
            if text.count > maxLength {
                let endIndex = text.index(text.startIndex, offsetBy: maxLength)
                let fixedText = text[text.startIndex..<endIndex]
                textField.text = fixedText + ""
                
                DispatchQueue.main.async {
                    self.keywordLimitLabel.isHidden = false
                    self.keywordTextField.text = String(fixedText)
                }
            } else {
                DispatchQueue.main.async {
                    self.keywordLimitLabel.isHidden = true
                }
            }
        }
    }
    
    // MARK: - selector
    
    @objc private func textFieldChangeBegin() {
        keywordTextField.placeholder = ""
        DispatchQueue.main.async {
            self.textFieldContainerView.layer.cornerRadius = Size.textFieldMinCornerRadius
        }
    }
    
    @objc private func textFieldChanging() {
        textFieldWidth = keywordTextField.intrinsicContentSize.width
        let textFieldContainerWidth: CGFloat = textFieldWidth + 2 * Size.textFieldXPadding
        var newCornerRadius: CGFloat = Size.textFieldMinCornerRadius
        if textFieldContainerWidth <= Size.textFieldHeight {
            newCornerRadius = textFieldContainerWidth / 2
        } else {
            newCornerRadius = Size.textFieldMaxCornerRadius
        }
        DispatchQueue.main.async {
            self.textFieldContainerView.layer.cornerRadius = newCornerRadius
            self.textFieldContainerView.snp.updateConstraints {
                $0.width.equalTo(self.textFieldWidth + 2 * Size.textFieldXPadding)
            }
        }
    }
    
    @objc private func textFieldChangeEnd() {
        if keywordTextField.text == "" {
            keywordTextField.placeholder = placeholder
            DispatchQueue.main.async {
                self.textFieldContainerView.snp.updateConstraints {
                    $0.width.equalTo(self.placeholderWidth + 2 * Size.textFieldXPadding)
                }
                self.textFieldContainerView.layer.cornerRadius = Size.textFieldMaxCornerRadius
            }
        }
    }
}

extension KeywordTextField: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkMaxLength(textField: keywordTextField, maxLength: Length.keywordMaxLength)
    }
}
