//
//  EditTeamNameViewController.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2023/04/11.
//

import UIKit

import Alamofire

final class EditTeamNameViewController: BaseTextFieldViewController {
    override var titleText: String {
        get {
            return TextLiteral.editTeamLabelText
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
    
    override var maxLength: Int {
        get {
            return 10
        }
        
        set {
            super.maxLength = newValue
        }
    }
    
    override var buttonText: String {
        get {
            return TextLiteral.doneButtonComplete
        }
        
        set {
            super.buttonText = newValue
        }
    }
    
    // MARK: - property
    
    private lazy var backButton: BackButton = {
        let button = BackButton()
        let action = UIAction { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDoneButton()
        setupDefaultTextFieldText()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let button = removeBarButtonItemOffset(with: backButton, offsetX: 10)
        let backButton = makeBarButtonItem(with: button)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
    }
    
    // MARK: - func
    
    private func setupDoneButton() {
        let action = UIAction { [weak self] _ in
            guard let teamName = self?.kigoTextField.text else { return }
            self?.dispatchTeamName(type: .patchEditTeamName(EditTeamNameDTO(team_name: teamName)))
        }
        self.doneButton.addAction(action, for: .touchUpInside)
    }
    
    private func setupDefaultTextFieldText() {
        self.kigoTextField.text = UserDefaultStorage.teamName
    }
    
    // MARK: - api
    
    private func dispatchTeamName(type: EditTeamNameEndPoint<EditTeamNameDTO>) {
        AF.request(
            type.address,
            method: type.method,
            parameters: type.body,
            encoder: JSONParameterEncoder.default,
            headers: type.headers
        ).responseDecodable(of: BaseModel<EditTeamNameResponse>.self) { json in
            if let data = json.value {
                dump(data)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
