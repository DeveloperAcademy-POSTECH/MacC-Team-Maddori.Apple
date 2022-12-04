//
//  KeywordTextField.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/12/04.
//

import UIKit

import SnapKit

final class KeywordTextField: UIView {
    
    enum Size {
        static let keywordTextFieldHeight: CGFloat = 50
    }
    var textFieldWidth: CGSize = .zero
    
    // MARK: - property
    
//    private let containerView: UIView = {
//        let view = UIView()
//        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
//        view.layer.cornerRadius = Size.keywordTextFieldHeight
//        view.layer.shadowOpacity = 0.13
//        view.layer.shadowOffset = CGSize(width: 0, height: 1)
//        return view
//    }()
    
    private lazy var keywordTextField: UITextField = {
        let textField = UITextField()
        // FIXME: placeholder는 textliteral에 넣어두기~
        textField.attributedPlaceholder = NSAttributedString(
            string: "키워드를 입력하세요",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.gray300,
                NSAttributedString.Key.font: UIFont.main
            ]
        )
        textFieldWidth = textField.intrinsicContentSize
        textField.font = .main
        return textField
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        setTextFieldObserver()
        self.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func render() {
//        self.addSubview(containerView)
//        containerView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
        
        self.addSubview(keywordTextField)
        keywordTextField.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(Size.keywordTextFieldHeight)
        }
    }
    
    // MARK: - func
    
    private func setTextFieldObserver() {
        keywordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .allEditingEvents)
    }
    
    // MARK: - selector
    
    @objc private func textFieldDidChange() {
        textFieldWidth = keywordTextField.intrinsicContentSize
        self.snp.updateConstraints {
            $0.width.equalTo(textFieldWidth)
        }
    }
}
