//
//  StartReflectionViewController.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/20.
//

import UIKit

import SnapKit

final class StartReflectionViewController: BaseViewController {
    
    let reflectionId: Int
    
    init(reflectionId: Int) {
        self.reflectionId = reflectionId
        super.init()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - property
    
    private lazy var blurredView: UIView = {
        let containerView = UIView()
        let blurEffect = UIBlurEffect(style: .light)
        let customBlurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.1)
        customBlurEffectView.frame = self.view.bounds
        let dimmedView = UIView()
        dimmedView.backgroundColor = .white.withAlphaComponent(0.6)
        dimmedView.frame = self.view.bounds
        
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
            // FIXME: - dismisschildview를 해서 blur를 내린 뒤 present?
            self?.presentSelectReflectionMemberViewController()
        }
        button.setTitle(TextLiteral.startReflectionViewControllerStartText, for: .normal)
        button.titleLabel?.font = .label2
        button.setTitleColor(.black100, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = .white100
        button.addAction(action, for: .touchUpInside)
        button.layer.shadowColor = UIColor.black100.cgColor
        button.layer.shadowRadius = 1
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize.zero
        button.layer.masksToBounds = false
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
        view.addSubview(blurredView)
        view.sendSubviewToBack(blurredView)
                
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
    
    // MARK: - setup
    
    private func setPopupGradient() {
        startPopupView.layoutIfNeeded()
        startPopupView.setGradient(colorTop: .gradientBlue100Top, colorBottom: .gradientBlue100Bottom)
    }
    
    // MARK: - func
    
    private func presentSelectReflectionMemberViewController() {
        let viewController = UINavigationController(rootViewController: SelectReflectionMemberViewController(reflectionId: reflectionId))
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
}
