//
//  LoginViewController.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/06.
//

import UIKit

import SnapKit

final class LoginViewController: BaseViewController {
    
    // MARK: - property
    
    private let keygoLogoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.imgKeygoLogo
        return imageView
    }()
    private let keygoLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.loginViewControllerLogoText
        label.font = .font(.bold, ofSize: 25)
        return label
    }()
    private let keygoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.loginViewControllerDescriptionText
        label.font = .font(.bold, ofSize: 18)
        return label
    }()
    
    // MARK: - life cycle
    
    override func configUI() {
        view.backgroundColor = .backgroundWhite
        setGradientText()
    }
    
    override func render() {
        view.addSubview(keygoLogoImage)
        keygoLogoImage.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        view.addSubview(keygoLabel)
        keygoLabel.snp.makeConstraints {
            $0.top.equalTo(keygoLogoImage.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(keygoDescriptionLabel)
        keygoDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(keygoLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - func
    
    private func setGradientText() {
        keygoLabel.layoutIfNeeded()
        keygoLabel.setTextGradientColorTopToBottom(bound: keygoLabel.bounds)
        
        keygoDescriptionLabel.layoutIfNeeded()
        keygoDescriptionLabel.setTextGradientColorTopToBottom(bound: keygoDescriptionLabel.bounds)
    }
}
