//
//  FavoriteReflectionCell.swift
//  Maddori.Apple
//
//  Created by LeeSungHo on 2022/11/03.
//

import UIKit

import SnapKit

final class FavoriteReflectionCell: BaseCollectionViewCell {
    
    // MARK: - property
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .label1
        label.textColor = .black100
        return label
    }()
    private let writerLabel: WriterLabelView = {
        let label = WriterLabelView()
        return label
    }()
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .gray400
        label.numberOfLines = 2
        return label
    }()
    private let rightImage: UIImageView = {
         let imageView = UIImageView()
         imageView.image = ImageLiterals.icRight
         imageView.tintColor = .gray400
         return imageView
     }()
    // MARK: - life cycle
    
    override func configUI() {
        backgroundColor = .backgroundWhite
    }
    
    override func render() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)

        }
    }
}
