//
//  ToastView.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2023/04/11.
//

import UIKit

import SnapKit

final class ToastView: UIView {
    let type: ToastType
    var isTappedCopyButton: Bool = false
    
    enum ToastType {
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
        
        var toastWidth: CGFloat {
            switch self {
            case .warning:
                return 213
            case .complete:
                return 218
            }
        }
    }
    
    private lazy var toastIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = type.icon
        imageView.tintColor = type.iconColor
        return imageView
    }()
    private lazy var toastLabel: UILabel = {
        let label = UILabel()
        label.text = type.text
        label.font = .toast
        label.textColor = .white100
        return label
    }()
    
    init(type: ToastType) {
        self.type = type
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.setGradient(colorTop: .gradientGrayTop, colorBottom: .gradientGrayBottom)
        self.render()
    }
    
    private func render() {
        self.addSubview(toastIcon)
        toastIcon.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(18)
        }
        
        self.addSubview(toastLabel)
        toastLabel.snp.makeConstraints {
            $0.leading.equalTo(toastIcon.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
    }
    
    func showToast(navigationController: UINavigationController) {
        if !isTappedCopyButton {
            isTappedCopyButton = true
            navigationController.view.addSubview(self)
            self.snp.makeConstraints {
                $0.top.equalToSuperview().inset(-60)
                $0.centerX.equalToSuperview()
                $0.height.equalTo(46)
                $0.width.equalTo(type.toastWidth)
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, animations: {
                self.transform = CGAffineTransform(translationX: 0, y: 115)
            }, completion: { _ in
                UIView.animate(withDuration: 1, delay: 0.8, animations: {
                    self.transform = .identity
                }, completion: { _ in
                    self.removeFromSuperview()
                    self.isTappedCopyButton = false
                })
            })
        }
    }
}
