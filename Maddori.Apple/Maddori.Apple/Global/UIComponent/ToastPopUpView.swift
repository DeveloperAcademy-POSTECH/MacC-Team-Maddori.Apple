//
//  ToastPopUp.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/10/21.
//

import UIKit

import SnapKit

enum ToastType {
    case complete
    case warning
    
    var message: String {
        switch self {
        case .complete:
            return "초대코드가 복사되었습니다"
        case .warning:
            return "아직 회고 시간이 아닙니다"
        }
    }
    
    var image: UIImage {
        switch self {
        case .complete:
            return UIImage.load(systemName: "check.circle.fill")
        case .warning:
            return UIImage.load(systemName: "exclamationmark.circle.fill")
        }
    }
    
    var color: UIColor {
        switch self {
        case .complete:
            return UIColor.green100
        case .warning:
            return UIColor.yellow300
        }
    }
    
    var inset: CGFloat {
        switch self {
        case .complete:
            return 10.0
        case .warning:
            return 12.0
        }
    }
}

class ToastPopUpView: UIView {
    
    // MARK: - properties
    
    var toastType: ToastType
    
    lazy var toastMessage: UILabel = {
        let label = UILabel()
        label.text = toastType.message
        return label
    }()
    
    lazy var toastImage: UIImageView = {
        let view = UIImageView()
        view.image = toastType.image
        view.tintColor = toastType.color
        return view
    }()
    
    // MARK: - life cycle
    
    init(type: ToastType) {
        super.init()
        self.toastType = type
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    private func render() {
        self.addSubview(toastImage)
        toastImage.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(16)
        }
        
        self.addSubview(toastMessage)
        toastMessage.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(14)
            $0.leading.equalTo(toastImage).offset(toastType.inset)
            $0.trailing.equalToSuperview().inset(22)
        }
    }
}
