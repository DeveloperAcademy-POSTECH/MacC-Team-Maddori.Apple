//
//  AddFeedbackContentViewController.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/10/19.
//

import UIKit

import SnapKit

final class AddFeedbackContentViewController: BaseViewController {
    
    // MARK: - property
    
    private let backButton = BackButton()
    private let exitButton = ExitButton()
    
    // MARK: - lifecycle

    // MARK: - functions
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let backButton = makeBarButtonItem(with: backButton)
        let exitButton = makeBarButtonItem(with: exitButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = exitButton
    }
}
