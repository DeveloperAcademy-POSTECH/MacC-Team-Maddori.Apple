//
//  EmptyReflectionView.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/06.
//

import UIKit

import SnapKit

final class EmptyReflectionView: UIView {
    
    private enum Size {
        static let calendarWidth: CGFloat = 60
        static let calendarHeight: CGFloat = 65
        static let calendarYOffset: CGFloat = -60
    }
    
    // MARK: - property
    
    private let emptyReflectionImageView: UIImageView = {
        let view = UIImageView()
        view.image = ImageLiterals.imgEmptyCalendar
        return view
    }()
    var emptyReflectionLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.emptyViewMyReflection
        label.textColor = .gray700
        label.font = .body3
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func render() {
        self.addSubview(emptyReflectionImageView)
        emptyReflectionImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(Size.calendarYOffset)
            $0.width.equalTo(Size.calendarWidth)
            $0.height.equalTo(Size.calendarHeight)
        }
        
        self.addSubview(emptyReflectionLabel)
        emptyReflectionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(emptyReflectionImageView.snp.bottom).offset(18)
        }
    }
}
