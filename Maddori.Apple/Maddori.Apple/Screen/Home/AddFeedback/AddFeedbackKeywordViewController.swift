//
//  AddFeedbackKeywordViewController.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/12/04.
//

import UIKit

import Alamofire
import SnapKit

final class AddFeedbackKeywordViewController: BaseViewController {
    
    enum Size {
        static let topPadding: Int = 8
        static let stepTopPadding: Int = 24
        static let descriptionTopPadding: Int = 12
        static let buttonViewHeight: Int = 72
    }
    var step: Int
    var currentStepString: String = ""
    var contentString: String
    
    var textViewHasText: Bool = false
    
    init(step: Int, content: String) {
        self.step = step
        self.contentString = content
        super.init()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - property
    lazy var backButton: BackButton = {
        let button = BackButton(type: .system)
        let action = UIAction { [weak self] _ in
            self?.didTappedBackButton()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private lazy var closeButton: CloseButton = {
        let button = CloseButton(type: .system)
        let action = UIAction { [weak self] _ in
            self?.didTappedCloseButton()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private lazy var progressImageView: UIImageView = {
        let imageView = UIImageView()
    }()
    private lazy var currentStepLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.sendFeedbackViewControllerCurrentStepLabel5
        label.textColor = .black100
        label.font = .title2
        label.setLineSpacing(to: 4)
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - life cycle
    
    
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let button = removeBarButtonItemOffset(with: backButton, offsetX: 10)
        let backButton = makeBarButtonItem(with: button)
        let closeButton = makeBarButtonItem(with: closeButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = closeButton
    }
    
    private func didTappedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func didTappedCloseButton() {
        self.dismiss(animated: true)
    }
    
    func didTappedDoneButton() {
        DispatchQueue.main.async {
            // FIXME: done button 눌렀을 때 action -> API, View 내리기
        }
    }
}

