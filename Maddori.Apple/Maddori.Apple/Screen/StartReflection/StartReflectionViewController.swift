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
    private let calendarImage: UIImageView = {
        let view = UIImageView()
        view.image = ImageLiterals.imgCalendar
        return view
    }()
    private let startPopupView = UIView()
    
    // MARK: - life cycle
    
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
                
        view.addSubview(startPopupView)
        startPopupView.snp.makeConstraints {
            $0.top.equalTo(blurView.snp.top).offset(139)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(165)
        }
        
        view.addSubview(calendarImage)
        calendarImage.snp.makeConstraints {
            $0.top.equalTo(blurView.snp.top).offset(92)
            $0.centerX.equalToSuperview()
        }
        
        startPopupView.layoutIfNeeded()
        startPopupView.setGradient(colorTop: .gradientBlueTop, colorBottom: .gradientBlueBottom)

        
    }
}
