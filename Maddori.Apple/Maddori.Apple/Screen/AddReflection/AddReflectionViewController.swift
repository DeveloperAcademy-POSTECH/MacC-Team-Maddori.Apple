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
    
    private lazy var closeButtonView: UIView = {
        let view = UIView()
        let button = CloseButton(type: .system)
        button.tintColor = .black100
        let action = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        view.addSubview(button)
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.addReflectionViewControllerTitle
        label.numberOfLines = 2
        label.font = .title
        label.textColor = .black100
        return label
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func render() {
        view.addSubview(closeButtonView)
        closeButtonView.snp.makeConstraints {
            $0.width.height.equalTo(44)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalToSuperview().inset(7)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(64)
        }
    }
}
