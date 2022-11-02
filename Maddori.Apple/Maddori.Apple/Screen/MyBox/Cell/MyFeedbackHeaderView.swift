//
//  MyFeedbackHeaderView.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/02.
//

import UIKit

import SnapKit

final class MyFeedbackHeaderView: UICollectionReusableView {
    
    // MARK: - property
    
    private let cssLabel: UILabel = {
        let label = UILabel()
        label.text = "Continue"
        label.font = .main
        label.textColor = .blue200
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func render() {
        self.addSubview(cssLabel)
        cssLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setCssLabelText(with index: Int) {
        cssLabel.text = FeedBackType.allCases[index].rawValue
    }
}
