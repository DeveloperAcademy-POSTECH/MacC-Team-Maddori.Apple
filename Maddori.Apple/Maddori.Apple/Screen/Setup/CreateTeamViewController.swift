//
//  CreateTeamViewController.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2022/10/22.
//

import UIKit

import SnapKit

final class CreateTeamViewController: BaseTextFieldViewController {
    
    override var titleText: String {
        get {
            return TextLiteral.createTeamViewControllerTitleLabel
        }
        
        set {
            super.titleText = newValue
        }
    }
    
    override var placeholderText: String {
        get {
            return TextLiteral.createTeamViewControllerTextFieldPlaceHolder
        }
        
        set {
            super.placeholderText = newValue
        }
    }
    
    override var buttonText: String {
        get {
            return TextLiteral.joinTeamViewControllerSubButtonText
        }
        
        set {
            super.buttonText = newValue
        }
    }
    
    override var maxLength: Int {
        get {
            return 10
        }
        
        set {
            super.maxLength = newValue
        }
    }
}
