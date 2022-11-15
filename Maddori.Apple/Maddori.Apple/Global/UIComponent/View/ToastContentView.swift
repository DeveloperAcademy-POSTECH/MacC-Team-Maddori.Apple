//
//  ToastContentView.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/14.
//

import UIKit

import SnapKit

enum toastType {
    case warning
    case complete
    
    var icon: UIImage {
        switch self {
        case .warning:
            return ImageLiterals.icWarning
        case .complete:
            return ImageLiterals.icComplete
        }
    }
    
    var iconColor: UIColor {
        switch self {
        case .warning:
            return .yellow300
        case .complete:
            return .green
        }
    }
    
    var text: String {
        switch self {
        case .warning:
            return TextLiteral.warningText
        case .complete:
            return TextLiteral.completeText
        }
    }
}

final class ToastContentView: UIView {
    
    var toastType: toastType? {
        didSet {
            setupAttribute()
        }
    }
    
    // MARK: - property
    
    private let toastIcon = UIImageView()
    private let toastLabel: UILabel = {
        let label = UILabel()
        label.font = .toast
        label.textColor = .white100
        return label
    }()
    
    // MARK: - life cycle
    
    func render() {
        superview?.addSubview(toastIcon)
        toastIcon.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        superview?.addSubview(toastLabel)
        toastLabel.snp.makeConstraints {
            $0.leading.equalTo(toastIcon.snp.trailing).offset(10)
            $0.centerY.equalToSuperview().offset(1)
            $0.trailing.equalToSuperview().inset(22)
        }
    }
    
    // MARK: - func
    
    private func setupAttribute() {
        self.toastIcon.image = toastType?.icon
        self.toastIcon.tintColor = toastType?.iconColor
        self.toastLabel.text = toastType?.text
    }
}
