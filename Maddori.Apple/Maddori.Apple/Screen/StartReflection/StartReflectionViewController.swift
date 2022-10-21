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
    private let startPopupView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    private let startLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.startReflectionViewControllerStartTitle
        label.font = .main
        label.textColor = .white100
        return label
    }()
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(TextLiteral.startReflectionViewControllerStartText, for: .normal)
        button.titleLabel?.font = .label2
        button.setTitleColor(.black100, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = .white100
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }
    
    override func configUI() {
        view.backgroundColor = .clear
        setPopupGradient()
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
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(165)
        }
        
        view.addSubview(calendarImage)
        calendarImage.snp.makeConstraints {
            $0.bottom.equalTo(startPopupView.snp.top).inset(39)
            $0.centerX.equalToSuperview()
        }
        
        startPopupView.addSubview(startLabel)
        startLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(59)
            $0.centerX.equalToSuperview()
        }
        
        startPopupView.addSubview(startButton)
        startButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(48)
            $0.bottom.equalToSuperview().inset(24)
            $0.height.equalTo(42)
        }
    }
    
    private func setPopupGradient() {
        startPopupView.layoutIfNeeded()
        startPopupView.setGradient(colorTop: .gradientBlue100Top, colorBottom: .gradientBlue100Bottom)
    }
}
