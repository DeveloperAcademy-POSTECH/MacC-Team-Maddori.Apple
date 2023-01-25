//
//  TeamDetailViewController.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2023/01/25.
//

import UIKit

import SnapKit

final class TeamDetailViewController: BaseViewController {
    
    // MARK: - property
    
    private lazy var backButton = BackButton(type: .system)
    
    override func configUI() {
        super.configUI()
        navigationController?.isNavigationBarHidden = false
    }
    
    override func render() {
        view.backgroundColor = .gray600
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let button = removeBarButtonItemOffset(with: backButton, offsetX: 10)
        let backButton = makeBarButtonItem(with: button)
        
        navigationItem.leftBarButtonItem = backButton
    }
}
