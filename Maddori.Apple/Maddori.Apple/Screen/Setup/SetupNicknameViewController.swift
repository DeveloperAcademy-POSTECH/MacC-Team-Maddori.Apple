//
//  SetupNicknameViewController.swift
//  Maddori.Apple
//
//  Created by LeeSungHo on 2022/10/20.
//

import UIKit

import SnapKit

final class SetupNicknameViewController: BaseTextFieldViewController {
    
    override var titleText: String {
        get {
            return TextLiteral.setupNicknameViewControllerTitleLabel
        }
        
        set {
            super.titleText = newValue
        }
    }
    
    override var placeholerText: String {
        get {
            return TextLiteral.setupNicknameViewControllerNicknameTextFieldPlaceHolder
        }
        
        set {
            super.placeholerText = newValue
        }
    }
}
