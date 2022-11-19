//
//  AddReflectionViewController.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/18.
//

import UIKit

import Alamofire
import SnapKit

final class CreateReflectionViewController: BaseViewController {
    
    var reflectionId: Int
    
    init(reflectionId: Int) {
        self.reflectionId = reflectionId
        super.init()
    }
    
    required init?(coder: NSCoder) { nil }
    
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
        label.setTitleFont(text: TextLiteral.createReflectionViewControllerTitle)
        label.textColor = .black100
        return label
    }()
    private let reflectionNameView = ReflectionNameView()
    private let reflectionDateLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.createReflectionViewControllerDateLabel
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
        button.title = TextLiteral.createReflectionViewControllerButtonText
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddReflection()
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
    
    // MARK: - setup
    
    private func setupAddReflection() {
        let action = UIAction { [weak self] _ in
            guard let reflectionDate = self?.combineDateAndTime(),
                  let reflectionName = self?.reflectionNameView.nameTextField.text,
                  let reflectionId = self?.reflectionId
            else { return }
            self?.patchReflectionDetail(type: .patchReflectionDetail(
                reflectionId: reflectionId,
                AddReflectionDTO(
                    reflection_name: reflectionName,
                    reflection_date: String(describing: reflectionDate)
                )
            ))
            self?.dismiss(animated: true)
        }
        mainButton.addAction(action, for: .touchUpInside)
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
    
    private func combineDateAndTime() -> Date {
        let date = datePicker.date
        let time = timePicker.date
        
        let calendar = NSCalendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
        
        var combinedDateComponents = DateComponents()
        combinedDateComponents.year = dateComponents.year
        combinedDateComponents.month = dateComponents.month
        combinedDateComponents.day = dateComponents.day
        combinedDateComponents.hour = timeComponents.hour
        combinedDateComponents.minute = timeComponents.minute
        
        guard let combinedDate = calendar.date(from: combinedDateComponents) else { return Date() }
        
        return combinedDate
    }
    
    // MARK: - api
    
    private func patchReflectionDetail(type: CreateReflectionEndPoint<AddReflectionDTO>) {
        AF.request(type.address,
                   method: type.method,
                   parameters: type.body,
                   encoder: JSONParameterEncoder.default,
                   headers: type.header
        ).responseDecodable(of: BaseModel<AddReflectionResponse>.self) {
            json in
            dump(json)
        }
    }
}
