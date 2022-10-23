//
//  StartReflectionViewController.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/20.
//

import UIKit

import SnapKit

final class StartReflectionView: UIView {
    
    // MARK: - property
    
    lazy var blurredView: UIView = {
           // 1. create container view
           let containerView = UIView()
           // 2. create custom blur view
           let blurEffect = UIBlurEffect(style: .light)
           let customBlurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.1)
           customBlurEffectView.frame = self.bounds
           // 3. create semi-transparent black view
           let dimmedView = UIView()
           dimmedView.backgroundColor = .white.withAlphaComponent(0.6)
           dimmedView.frame = self.bounds
           
           // 4. add both as subviews
           containerView.addSubview(customBlurEffectView)
           containerView.addSubview(dimmedView)
           return containerView
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
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        let action = UIAction { [weak self] _ in
//            self?.dismiss(animated: true)
        }
        button.setTitle(TextLiteral.startReflectionViewControllerStartText, for: .normal)
        button.titleLabel?.font = .label2
        button.setTitleColor(.black100, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = .white100
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configUI()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func configUI() {
        self.backgroundColor = .clear
        setPopupGradient()
    }
    
    private func render() {
        
        self.addSubview(blurredView)
        self.sendSubviewToBack(blurredView)
//        blurredView.snp.makeConstraints {
//            $0.leading.trailing.bottom.equalToSuperview()
//            $0.top.equalToSuperview().inset(100)
//        }
                
        self.addSubview(startPopupView)
        startPopupView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(165)
        }
        
        self.addSubview(calendarImage)
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

final class CustomVisualEffectView: UIVisualEffectView {
    /// Create visual effect view with given effect and its intensity
    ///
    /// - Parameters:
    ///   - effect: visual effect, eg UIBlurEffect(style: .dark)
    ///   - intensity: custom intensity from 0.0 (no effect) to 1.0 (full effect) using linear scale
    init(effect: UIVisualEffect, intensity: CGFloat) {
        theEffect = effect
        customIntensity = intensity
        super.init(effect: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { nil }
    
    deinit {
        animator?.stopAnimation(true)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        effect = nil
        animator?.stopAnimation(true)
        animator = UIViewPropertyAnimator(duration: 1, curve: .linear) { [unowned self] in
            self.effect = theEffect
        }
        animator?.fractionComplete = customIntensity
    }
    
    private let theEffect: UIVisualEffect
    private let customIntensity: CGFloat
    private var animator: UIViewPropertyAnimator?
}
