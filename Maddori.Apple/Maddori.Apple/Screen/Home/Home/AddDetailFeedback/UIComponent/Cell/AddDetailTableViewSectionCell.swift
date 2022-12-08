//
//  AddDetailTableViewSectionCell.swift
//  Maddori.Apple
//
//  Created by LeeSungHo on 2022/12/06.
//

import UIKit

import SnapKit

final class AddDetailTableViewSectionCell: BaseTableViewCell {
    
    // MARK: - property
    
    var isOpened: Bool = false {
        didSet {
            if isOpened {
                self.layer.borderWidth = 0.2
                self.layer.borderColor = UIColor.black100.cgColor
                self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                self.layer.cornerRadius = 10
                
                UIView.animate(withDuration: 0.2) {
                    self.cellToggleImageView.transform = CGAffineTransform(rotationAngle: .pi)
                }
            }
            else {
                self.layer.borderWidth = 0.2
                self.layer.borderColor = UIColor.black100.cgColor
                self.layer.cornerRadius = 10
                
                UIView.animate(withDuration: 0.2) {
                    self.cellToggleImageView.transform = .identity
                }
            }
        }
    }
    
    let cellTitle: UILabel = {
        let label = UILabel()
        label.font = .main
        return label
    }()
    
    let cellToggleImageView: UIImageView = {
        let imageView = UIImageView(image: ImageLiterals.icBottom)
        imageView.tintColor = .black100
        return imageView
    }()
    
    // MARK: - life cycle
    
    override func configUI() {

        self.layer.masksToBounds = true
    }
    
    override func render() {
        
        self.addSubview(cellTitle)
        cellTitle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        self.addSubview(cellToggleImageView)
        cellToggleImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}
