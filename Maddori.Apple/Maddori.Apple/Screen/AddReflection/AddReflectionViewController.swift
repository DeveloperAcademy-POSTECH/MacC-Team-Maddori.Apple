//
//  AddReflectionViewController.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/18.
//

import UIKit

import SnapKit

final class AddReflectionViewController: BaseViewController {
    
    // MARK: - property
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(.load(systemName: "xmark"), for: .normal)
        return button
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configUI() {
        view.backgroundColor = .blue200
    }
    
    override func setupNavigationBar() {
        let item = UIBarButtonItem(customView: closeButton)
        self.navigationItem.rightBarButtonItem = item
    }
}
