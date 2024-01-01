//
//  NewKeywordCollectionViewCell.swift
//  Maddori.Apple
//
//  Created by 이성민 on 1/1/24.
//

import UIKit

final class NewKeywordCollectionViewCell: UICollectionViewCell {
    
    enum CellType {
        case preview, main, sub, seen
        
        var corners: CACornerMask {
            switch self {
            case .preview:
                return [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
            default:
                return [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            }
        }
        
        var cellColor: [UIColor] {
            switch self {
            case .main:
                return [.gradientBlueTop, .gradientBlueBottom]
            default:
                return [.white100, .white100]
            }
        }
        
        var textColor: UIColor {
            switch self {
            case .main:
                return .white100
            case .seen:
                return .gray300
            default:
                return .gray600
            }
        }
        
        var shadowOpacity: Float {
            switch self {
            case .preview:
                return 0.13
            default:
                return 0.25
            }
        }
        
        var shadowRadius: CGFloat {
            switch self {
            case .seen:
                return 1
            default:
                return 4
            }
        }
    }
    
    // MARK: - ui property
    
    private let keywordLabel: UILabel = {
        let label = UILabel()
        label.font = .main
        return label
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - setup
    
    private func setupLayout() {
        self.contentView.addSubview(keywordLabel)
        keywordLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.verticalEdges.equalToSuperview().inset(12)
        }
    }
}

extension NewKeywordCollectionViewCell {
    func configureLabel(text: String) {
        self.keywordLabel.text = text
    }
    
    func configureUI(type: CellType) {
        self.keywordLabel.textColor = type.textColor
        self.contentView.backgroundColor = type.cellColor[0]
        self.contentView.layer.maskedCorners = type.corners
        self.contentView.layer.cornerRadius = 25
        self.contentView.layer.masksToBounds = true
        self.layer.shadowRadius = type.shadowRadius
        self.layer.shadowOpacity = type.shadowOpacity
        self.layer.shadowOffset = .init(width: 0, height: 0)
    }
}
