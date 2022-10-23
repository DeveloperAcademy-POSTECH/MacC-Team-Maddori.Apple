//
//  SetupNicknameViewController.swift
//  Maddori.Apple
//
//  Created by LeeSungHo on 2022/10/20.
//

import UIKit

final class SetupNicknameViewController: BaseTextFieldViewController {
    
    override var titleText: String {
        get {
            return TextLiteral.setupNicknameViewControllerTitleLabel
        }
        set {
            super.titleText = newValue
        }
    }
    
    override var placeholderText: String {
        get {
            return TextLiteral.setupNicknameViewControllerNicknameTextFieldPlaceHolder
        }
        set {
            super.placeholderText = newValue
        }
    }
    
    override var buttonText: String {
        get {
            return TextLiteral.doneButtonTitle
        }
        set {
            super.buttonText = newValue
        }
    }
}
