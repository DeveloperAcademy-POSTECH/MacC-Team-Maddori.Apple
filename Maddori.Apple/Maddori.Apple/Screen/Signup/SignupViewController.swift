//
//  SignupViewController.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2022/10/18.
//

import UIKit

import SnapKit

final class SignupViewController: BaseViewController {
    
    // MARK: - property
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "키고에서 사용할 \n닉네임을 입력해주세요"
        label.font = .title
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        render()
    }
    
    override func configUI() {
        super.configUI()
    }
    
    override func render() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(Size.topPadding)
            $0.leading.equalToSuperview().inset(Size.leadingTrailingPadding)
        }
    }
    // MARK: - function
    
    // MARK: - selector
}


enum Size {
    static let leadingTrailingPadding: Int = 24
    static let topPadding: Int = 20
}
