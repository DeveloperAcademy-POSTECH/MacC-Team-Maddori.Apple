//
//  ReflectionCollectionViewHeader.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/02.
//

import UIKit

import SnapKit
// FIXME: 도저히 머리가 안돌아가서 실천하기 란을 special로 이름을 지었습니다
// 이거 좀 아이디어 좀 주세요...
enum headerType {
    case special
    case total
    
    var iconImage: UIImage {
        switch self {
        case .special:
            return ImageLiterals.icPin
        case .total:
            return ImageLiterals.icBox
        }
    }
    
    var iconColor: UIColor {
        switch self {
        case .special:
            return UIColor.yellow200
        case .total:
            return UIColor.blue200
        }
    }
    
    var labelText: String {
        switch self {
        case .special:
            // FIXME: 실천하기도 레이블링 바꾸기로 했었는데 일단 생각이 안나서 이렇게 둡니다...
            return "실천하기"
        case .total:
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
    lazy var headerLabel: UILabel = {
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
        
        self.addSubview(headerLabel)
        headerLabel.snp.makeConstraints {
            $0.bottom.equalTo(headerIcon).offset(-3)
            $0.leading.equalTo(headerIcon.snp.trailing).offset(5)
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
        headerLabel.text = headerType.labelText
    }
}
