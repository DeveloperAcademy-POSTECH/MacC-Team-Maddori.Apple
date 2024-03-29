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
    var reflectionTitle: String?
    var reflectionDate: Date?
    
    var isEditReflection: Bool = false
    
    init(reflectionId: Int) {
        self.reflectionId = reflectionId
        super.init()
    }
    
    init(reflectionId: Int, reflectionTitle: String?, reflectionDate: String?) {
        self.reflectionId = reflectionId
        self.reflectionTitle = reflectionTitle
        self.reflectionDate = reflectionDate?.formatStringToDate()
        self.isEditReflection = true
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
    private lazy var deleteButton: DeleteButton = {
        let button = DeleteButton(type: .system)
        return button
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.setTitleFont(text: isEditReflection ? TextLiteral.editReflectionViewControllerTitle : TextLiteral.createReflectionViewControllerTitle)
        label.textColor = .black100
        return label
    }()
    private lazy var reflectionNameView: ReflectionNameView = {
        let nameView = ReflectionNameView()
        if isEditReflection {
            nameView.nameTextField.text = reflectionTitle
        }
        return nameView
    }()
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
        let hideKeyboardAction = UIAction { [weak self] _ in
            self?.view.endEditing(true)
        }
        if isEditReflection, let date = reflectionDate {
            picker.date = date
        }
        picker.datePickerMode = .date
        picker.locale = Locale(identifier: "ko_KR")
        picker.preferredDatePickerStyle = .compact
        picker.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .white300
        picker.subviews.first?.subviews.first?.subviews.first?.layer.borderWidth = 1
        picker.subviews.first?.subviews.first?.subviews.first?.layer.borderColor = UIColor.gray100.cgColor
        picker.addAction(action, for: .valueChanged)
        picker.addAction(hideKeyboardAction, for: .editingDidBegin)
        return picker
    }()
    private lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        let action = UIAction { [weak self] _ in
            picker.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .white300
        }
        let hideKeyboardAction = UIAction { [weak self] _ in
            self?.view.endEditing(true)
        }
        if !isEditReflection {
            picker.date = Date(timeIntervalSinceNow: 1 * 60)
        } else if isEditReflection, let date = reflectionDate {
            picker.date = date
        }
        picker.datePickerMode = .time
        picker.locale = Locale(identifier: "ko_KR")
        picker.preferredDatePickerStyle = .inline
        picker.subviews.first?.subviews.first?.backgroundColor = .white300
        picker.subviews.first?.subviews.first?.layer.borderWidth = 1
        picker.subviews.first?.subviews.first?.layer.borderColor = UIColor.gray100.cgColor
        picker.addAction(action, for: .valueChanged)
        picker.addAction(hideKeyboardAction, for: .editingDidBegin)
        return picker
    }()
    private lazy var mainButton: MainButton = {
        let button = MainButton()
        button.isDisabled = isEditReflection ? false : true
        button.title = isEditReflection ? TextLiteral.editReflectionViewControllerButtonText : TextLiteral.createReflectionViewControllerButtonText
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddReflection()
        setupNotificationCenter()
        setupTextfieldObserver()
        if isEditReflection {
            setupDeleteReflection()
        }
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
        if !isEditReflection {
            let closeButton = makeBarButtonItem(with: closeButton)
            navigationItem.rightBarButtonItem = closeButton
        } else {
            let closeButton = makeBarButtonItem(with: closeButton)
            let deleteButton = makeBarButtonItem(with: deleteButton)
            navigationItem.leftBarButtonItem = closeButton
            navigationItem.rightBarButtonItem = deleteButton
        }
    }
    
    // MARK: - setup
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupTextfieldObserver() {
        reflectionNameView.nameTextField.addTarget(self, action: #selector(texfieldHasContent), for: .editingChanged)
    }
    
    private func setupAddReflection() {
        let action = UIAction { [weak self] _ in
            guard let reflectionDate = self?.combineDateAndTime(),
                  let reflectionName = self?.reflectionNameView.nameTextField.text,
                  let reflectionId = self?.reflectionId
            else { return }
            if reflectionDate >= Date() {
                self?.patchReflectionDetail(type: .patchReflectionDetail(
                    reflectionId: reflectionId,
                    AddReflectionDTO(
                        reflection_name: reflectionName,
                        reflection_date: String(describing: reflectionDate)
                    )
                ))
            } else {
                self?.makeAlert(title: TextLiteral.createReflectionAlertTitle, message: TextLiteral.createReflectionAlertContent)
            }
        }
        mainButton.addAction(action, for: .touchUpInside)
    }
    
    private func setupDeleteReflection() {
        let action = UIAction { [weak self] _ in
            guard let reflectionId = self?.reflectionId else { return }
            
            let alert = UIAlertController(
                title: TextLiteral.deleteReflectionAlertTitle,
                message: TextLiteral.deleteReflectionAlertDetail,
                preferredStyle: .alert
            )
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
            let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { [weak self] _ in
                self?.deleteReflectionDetail(type: .deleteReflectionDetail(reflectionId: reflectionId))
                self?.dismiss(animated: true)
            }
            
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            
            self?.present(alert, animated: true)
        }
        deleteButton.addAction(action, for: .touchUpInside)
    }
    
    // MARK: - func
    
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
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // MARK: - selector
    
    @objc private func keyboardWillShow(notification:NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.mainButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 10)
            })
        }
    }
    
    @objc private func keyboardWillHide(notification:NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.mainButton.transform = .identity
        })
    }
    
    @objc private func texfieldHasContent() {
        if reflectionNameView.nameTextField.hasText {
            
            mainButton.isDisabled = false
        } else {
            mainButton.isDisabled = true
        }
    }
    
    // MARK: - api
    
    private func patchReflectionDetail(type: CreateReflectionEndPoint<AddReflectionDTO>) {
        AF.request(type.address,
                   method: type.method,
                   parameters: type.body,
                   encoder: JSONParameterEncoder.default,
                   headers: type.header
        ).responseDecodable(of: BaseModel<ReflectionResponse>.self) { [weak self] json in
            if let _ = json.value {
                self?.dismiss(animated: true)
            }
        }
    }
    
    private func deleteReflectionDetail(type: CreateReflectionEndPoint<VoidModel>) {
        AF.request(type.address,
                   method: type.method,
                   parameters: type.body,
                   encoder: JSONParameterEncoder.default,
                   headers: type.header
        ).responseDecodable(of: BaseModel<ReflectionResponse>.self) { json in
            if let data = json.value {
                dump(data)
            }
        }
    }
}
