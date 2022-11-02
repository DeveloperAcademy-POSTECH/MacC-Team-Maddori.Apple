//
//  MyBoxViewController.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/02.
//

import UIKit

import SnapKit

final class MyBoxViewController: BaseViewController {
    
    // MARK: - property
    
    private let myFeedbackLabel: UILabel = {
        let label = UILabel()
        label.setTitleFont(text: "내가 작성한 피드백")
        return label
    }()
    
    // MARK: - life cycle
    
    override func render() {
        view.addSubview(myFeedbackLabel)
        myFeedbackLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
    }
}
