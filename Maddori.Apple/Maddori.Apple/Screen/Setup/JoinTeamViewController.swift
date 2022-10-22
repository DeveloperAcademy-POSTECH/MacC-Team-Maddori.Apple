//
//  JoinTeamViewController.swift
//  Maddori.Apple
//
//  Created by LeeSungHo on 2022/10/20.
//

import UIKit

import SnapKit

final class JoinTeamViewController: BaseTextFieldViewController {
    
    override var titleText: String {
        get {
            return TextLiteral.joinTeamViewControllerTitleLabel
        }
        
        set {
            super.titleText = newValue
        }
    }
    
    override var placeholerText: String {
        get {
            return TextLiteral.joinTeamViewControllerNicknameTextFieldPlaceHolder
        }
        
        set {
            super.placeholerText = newValue
        }
    }
    
    // MARK: - property
    let subView: LabelButtonView = {
        let view = LabelButtonView()
        view.buttonAction = { 
            print("s")
        }
        return view
    }()
        
    override func render() {
        super.render()
        
        view.addSubview(subView)
        subView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(super.doneButton.snp.top)
            $0.height.equalTo(44)
        }
    }
}
