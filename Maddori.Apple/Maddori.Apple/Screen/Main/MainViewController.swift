//
//  MainViewController.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/14.
//

import UIKit

import SnapKit

final class MainViewController: BaseViewController {
    
    // MARK: - property
    
    private let mainButton: MainButton = {
        let button = MainButton()
        button.title = "예시"
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configUI() {
        view.backgroundColor = .backgrounWhite
    }
    
    override func render() {
        view.addSubview(mainButton)
        mainButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
        }
    }
}
