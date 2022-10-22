//
//  Label+ButtonView.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2022/10/22.
//

import UIKit

import SnapKit

class LabelButtonView: UIView {
    
    var buttonAction: (() -> ())?
    
    var subText: String = "" {
        didSet {
            subLabel.text = subText
        }
    }
    
    var subButtonText: String = "" {
        didSet {
            subButton.setTitle(subButtonText, for: .normal)
        }
    }
    
    // MARK: - property
    
    private lazy var subButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(subButtonText, for: .normal)
        button.titleLabel?.font = .body2
        let action = UIAction { [weak self] _ in
            self?.buttonAction?()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private lazy var subLabel: UILabel = {
        let label = UILabel()
        label.text = subText
        label.font = .body2
        label.textColor = .gray400
        return label
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    func render() {
        self.addSubview(subLabel)
        subLabel.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
        }
        
        self.addSubview(subButton)
        subButton.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview()
            $0.leading.equalTo(subLabel.snp.trailing).offset(4)
        }
    }
}
