//
//  EmptyPersonView.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2023/01/10.
//

import UIKit

import SnapKit

final class EmptyPersonView: UIView {
    
    // MARK: - property
    
    private lazy var emptyIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.icPersonCircle
        imageView.tintColor = .gray700
        let config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 50, weight: .thin))
        imageView.preferredSymbolConfiguration = config
        return imageView
    }()
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.myFeedbackViewControllerEmptyViewLabel
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
        self.addSubview(emptyIcon)
        emptyIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-40)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(60)
        }
        
        self.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints {
            $0.top.equalTo(emptyIcon.snp.bottom).offset(21)
            $0.centerX.equalToSuperview()
        }
    }
}
