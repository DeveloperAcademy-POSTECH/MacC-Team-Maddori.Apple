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
    
    // MARK: - property
    private lazy var subbutton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("팀 생성하기", for: .normal)
        button.titleLabel?.font = .body2
        let action = UIAction { [weak self] _ in
            self?.buttonAction?()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.text = "팀이 없나요?"
        label.font = .body2
        label.textColor = .gray400
        return label
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    func render() {
        self.addSubview(subLabel)
        subLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview().offset(-35)
        }
        
        self.addSubview(subbutton)
        subbutton.snp.makeConstraints {
            $0.leading.equalTo(subLabel.snp.trailing).offset(5)
            $0.centerY.equalToSuperview()
        }
    }
}
