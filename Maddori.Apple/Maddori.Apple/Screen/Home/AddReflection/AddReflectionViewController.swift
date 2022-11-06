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
    
    private lazy var closeButton: CloseButton = {
        let button = CloseButton(type: .system)
        let action = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.setTitleFont(text: TextLiteral.addReflectionViewControllerTitle)
        label.textColor = .black100
        return label
    }()
    private let reflectionNameView = ReflectionNameView()
    private let reflectionDateLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.addReflectionViewControllerDateLabel
        label.font = .label2
        label.textColor = .black100
        return label
    }()
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        let action = UIAction { [weak self] _ in
            picker.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .white300
        }
        picker.datePickerMode = .date
        picker.locale = Locale(identifier: "ko_KR")
        picker.preferredDatePickerStyle = .compact
        picker.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .white300
        picker.subviews.first?.subviews.first?.subviews.first?.layer.borderWidth = 1
        picker.subviews.first?.subviews.first?.subviews.first?.layer.borderColor = UIColor.gray100.cgColor
        picker.addAction(action, for: .valueChanged)
        return picker
    }()
    private lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        let action = UIAction { [weak self] _ in
            picker.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .white300
        }
        picker.datePickerMode = .time
        picker.locale = Locale(identifier: "ko_KR")
        picker.preferredDatePickerStyle = .inline
        picker.subviews.first?.subviews.first?.backgroundColor = .white300
        picker.subviews.first?.subviews.first?.layer.borderWidth = 1
        picker.subviews.first?.subviews.first?.layer.borderColor = UIColor.gray100.cgColor
        picker.addAction(action, for: .valueChanged)
        return picker
    }()
    private lazy var mainButton: MainButton = {
        let button = MainButton()
        button.title = TextLiteral.addReflectionViewControllerButtonText
        let action = UIAction { [weak self] _ in
            // FIXME: - 특정 시간이 되면 함수 실행하도록 변경. 현재는 확인용
            self?.showStartReflectionView()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func render() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(SizeLiteral.topPadding)
        }
        
        view.addSubview(reflectionNameView)
        reflectionNameView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.height.equalTo(103)
        }
        
        view.addSubview(reflectionDateLabel)
        reflectionDateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalTo(reflectionNameView.snp.bottom).offset(29)
        }
        
        view.addSubview(timePicker)
        timePicker.snp.makeConstraints {
            $0.centerY.equalTo(reflectionDateLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(18)
        }
        
        view.addSubview(datePicker)
        datePicker.snp.makeConstraints {
            $0.centerY.equalTo(reflectionDateLabel.snp.centerY)
            $0.trailing.equalTo(timePicker.snp.leading).inset(2)
        }
        
        view.addSubview(mainButton)
        mainButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(2)
        }
    }
    
    override func setupNavigationBar() {
        let item = makeBarButtonItem(with: closeButton)
        navigationItem.rightBarButtonItem = item
    }
    
    // MARK: - func
    
    private func showStartReflectionView() {
        let childView = StartReflectionViewController()
        childView.dismissChildView = {
            childView.willMove(toParent: nil)
            childView.removeFromParent()
            childView.view.removeFromSuperview()
        }
        childView.view.alpha = 0
        self.addChild(childView)
        self.view.addSubview(childView.view)
        self.didMove(toParent: childView)
        UIView.animate(withDuration: 1, animations: {
            childView.view.alpha = 1
        })
    }
}
