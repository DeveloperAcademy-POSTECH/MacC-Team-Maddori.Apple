//
//  AddDetailFeedbackViewController.swift
//  Maddori.Apple
//
//  Created by LeeSungHo on 2022/12/06.
//

import UIKit

import SnapKit

final class AddDetailFeedbackViewController: BaseViewController {
    
    private var sections: [Section] = []
    
    // MARK: - property
    
    private let closeButton = CloseButton()
    private let progressImageView = UIImageView(image: ImageLiterals.imgProgress1)
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "피드백 줄 멤버와 종류를\n선택해주세요"
        label.numberOfLines = 0
        label.font = .title2
        return label
    }()
    private let nextButton: MainButton = {
        let button = MainButton()
        button.title = TextLiteral.doneButtonNext
        return button
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(AddDetailTableViewSectionCell.self, forCellReuseIdentifier: AddDetailTableViewSectionCell.className)
        tableView.register(AddDetailTableViewSelectMemberCell.self, forCellReuseIdentifier: AddDetailTableViewSelectMemberCell.className)
        tableView.register(AddDetailTableViewSelectFeedbackTypeCell.self, forCellReuseIdentifier: AddDetailTableViewSelectFeedbackTypeCell.className)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCloseButton()
        setupSection()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let closeButton = makeBarButtonItem(with: closeButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = closeButton
    }
    
    override func render() {
        
        view.addSubview(progressImageView)
        progressImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.width.equalTo(110)
            $0.height.equalTo(14)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(progressImageView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(2)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.bottom.equalTo(nextButton.snp.top).offset(-47)
        }
    }
    
    // MARK: - func
    
    private func setupSection() {
        sections = [
            Section(title: "피드백 줄 맴버", isOpened: true),
            Section(title: "피드백 종류")
        ]
    }
    
    private func setupCloseButton() {
        let action = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
        closeButton.addAction(action, for: .touchUpInside)
    }
}

extension AddDetailFeedbackViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        
        if section.isOpened {
            return sections.count
        }
        else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddDetailTableViewSectionCell.className, for: indexPath) as? AddDetailTableViewSectionCell else { return UITableViewCell() }
            cell.cellTitle.text = sections[indexPath.section].title
            cell.isOpened = sections[indexPath.section].isOpened
            return cell
        }
        else if indexPath.section == 0, indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddDetailTableViewSelectMemberCell.className, for: indexPath) as? AddDetailTableViewSelectMemberCell else { return UITableViewCell()}
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddDetailTableViewSelectFeedbackTypeCell.className, for: indexPath) as? AddDetailTableViewSelectFeedbackTypeCell else { return UITableViewCell()}
            return cell
        }
    }
}

extension AddDetailFeedbackViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if indexPath.row == 0 {
            sections[indexPath.section].isOpened = !sections[indexPath.section].isOpened
            tableView.reloadSections([indexPath.section], with: .none)
        }
        else {
            print("tap")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 58
        }
        else if indexPath.section == 0 && indexPath.row == 1 {
            return 207
        }
        else {
            return 121
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
         return 20
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
         return UIView()
    }
}


struct Section {
    let title: String
    var isOpened = false
    
    init(title: String, isOpened: Bool = false) {
        self.title = title
        self.isOpened = isOpened
    }
}
