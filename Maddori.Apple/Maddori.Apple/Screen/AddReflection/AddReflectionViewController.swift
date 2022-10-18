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
    private let mainButton: MainButton = {
        let button = MainButton()
        button.isDisabled = true
        button.title = "추가하기"
        return button
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
        
        view.addSubview(reflectionNameView)
        reflectionNameView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.height.equalTo(103)
        }
        
        view.addSubview(reflectionDateLabel)
        reflectionDateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalTo(reflectionNameView.snp.bottom).offset(29)
        }
        
        view.addSubview(datePicker)
        datePicker.snp.makeConstraints {
            $0.centerY.equalTo(reflectionDateLabel.snp.centerY)
            $0.leading.equalTo(reflectionDateLabel.snp.trailing).offset(25)
        }
        
        view.addSubview(timePicker)
        timePicker.snp.makeConstraints {
            $0.centerY.equalTo(reflectionDateLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(18)
        }
        
        view.addSubview(mainButton)
        mainButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(2)
        }
    }
}
