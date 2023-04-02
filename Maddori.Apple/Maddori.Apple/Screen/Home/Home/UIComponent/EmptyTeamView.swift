//
//  EmptyTeamView.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2023/03/03.
//

import UIKit

import SnapKit

final class EmptyTeamView: UIView {
    
    // MARK: - property
    
    private let emptyTeamImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.imgEmptyTeam
        imageView.tintColor = .gray700
        return imageView
    }()
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.teamManageViewControllerEmptyLabel
        label.setLineSpacing(to: 4)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .gray700
        label.font = .body3
        return label
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func render() {
        self.addSubview(emptyTeamImage)
        emptyTeamImage.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-60)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(63)
            $0.height.equalTo(30)
        }
        
        self.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints {
            $0.top.equalTo(emptyTeamImage.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
}
