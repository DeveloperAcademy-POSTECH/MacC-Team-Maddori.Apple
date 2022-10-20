//
//  StartReflectionViewController.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/20.
//

import UIKit

import SnapKit

final class StartReflectionViewController: BaseViewController {
    
    // MARK: - property
    
    private let blurView: UIVisualEffectView = {
        let effectView = UIVisualEffectView()
        let blurEffect = UIBlurEffect(style: .light)
        effectView.effect = blurEffect
        return effectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configUI() {
        view.backgroundColor = .clear
    }
    
    override func render() {
        view.addSubview(blurView)
        blurView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            $0.bottom.equalToSuperview()
        }
    }
}
