//
//  InProgressViewController.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/10/24.
//

import UIKit

import SnapKit

final class InProgressViewController: BaseViewController {
    
    private let name = "진저"
    
    // MARK: - properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.setTitleFont(text: name +  TextLiteral.InProgressViewControllerTitleLabel)
        label.textColor = .black100
        label.numberOfLines = 0
        return label
    }()
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .caption1
        label.textColor = .gray400
        label.text = name + TextLiteral.InProgressViewControllerSubTitleLabel
        return label
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - func
    
    override func render() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(SizeLiteral.titleSubTitlePadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
    }
    
}
