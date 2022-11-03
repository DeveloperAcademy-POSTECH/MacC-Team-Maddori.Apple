//
//  ReflectionCollectionViewHeader.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/02.
//

import UIKit

import SnapKit

enum headerType {
    case special
    case reflection
    
    var iconImage: UIImage {
        switch self {
        case .special:
            return ImageLiterals.icPin
        case .reflection:
            return ImageLiterals.icBox
        }
    }
    
    var iconColor: UIColor {
        switch self {
        case .special:
            return UIColor.yellow200
        case .reflection:
            return UIColor.blue200
        }
    }
    
    var labelText: String {
        switch self {
        case .special:
            return "즐겨찾기"
        case .reflection:
            return "모음집"
        }
    }
}

final class ReflectionCollectionViewHeader: UICollectionReusableView {
    
    var type: headerType = .special
    
    // MARK: - property
    
    lazy var headerIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = type.iconImage
        imageView.tintColor = type.iconColor
        return imageView
    }()
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = type.labelText
        label.font = .label3
        return label
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configUI()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - func
    
    private func render() {
        self.addSubview(headerIcon)
        headerIcon.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(6)
            $0.leading.equalToSuperview()
            $0.height.width.equalTo(28)
        }
        
        self.addSubview(label)
        label.snp.makeConstraints {
            $0.centerY.equalTo(headerIcon)
            $0.leading.equalTo(headerIcon.snp.trailing).offset(8)
        }
    }
    
    private func configUI() {
        self.backgroundColor = .white200
    }
    
    func configIcon(to headerType: headerType) {
        headerIcon.image = headerType.iconImage
        headerIcon.tintColor = headerType.iconColor
    }
    
    func configLabel(to headerType: headerType) {
        label.text = headerType.labelText
    }
}
