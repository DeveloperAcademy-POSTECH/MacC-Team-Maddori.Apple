//
//  AddDetailFeedbackViewController.swift
//  Maddori.Apple
//
//  Created by LeeSungHo on 2022/12/06.
//

import UIKit

import SnapKit

final class AddDetailFeedbackViewController: BaseViewController {
    
    private var tableViewData: [cellData] = []
    
    // MARK: - property
    
    private let closeButton = CloseButton()
    // FIXME(이드 PR 합쳐지면 이미지 변경 예정)
    private let progressImageView = UIImageView(image: UIImage(systemName: "heart"))
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "피드백 줄 멤버와 종류를\n선택해주세요"
        label.numberOfLines = 0
        // FIXME: 이드꺼 머지되면 .title2 로 변경 예정
        label.font = .font(.bold, ofSize: 24)
        return label
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.className)
        return tableView
    }()
    private let nextButton: MainButton = {
        let button = MainButton()
        // FIXME: 텍스트 리터럴 처리하기
        button.title = "다음"
        return button
    }()
    
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCloseButton()
        setupTableViewData()
        setupDelegation()
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
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.bottom.equalTo(nextButton.snp.top).offset(-47)
        }
        
    }
    
    // MARK: - func
    
    private func setupCloseButton() {
        let action = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
        closeButton.addAction(action, for: .touchUpInside)
    }
    
    private func setupTableViewData() {
        tableViewData = [cellData(opened: false, title: "피드백 줄 맴버", sectionData: ["cell1", "cell2"]),
                         cellData(opened: false, title: "피드백 종류", sectionData: ["cell3", "cell4"])
        ]
    }
    
    private func setupDelegation() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension AddDetailFeedbackViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            return tableViewData[section].sectionData.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.className, for: indexPath) as? UITableViewCell else { return UITableViewCell() }
            cell.textLabel?.text = tableViewData[indexPath.section].title
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.className, for: indexPath) as? UITableViewCell else { return UITableViewCell() }
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
            return cell
        }
    }
}

extension AddDetailFeedbackViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            tableViewData[indexPath.section].opened = !tableViewData[indexPath.section].opened
            tableView.reloadSections([indexPath.section], with: .none)
        } else {
            print("이건 sectionData 선택한 거야")
        }
    }
}

// FIXME: 모델로 뺄것
struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}
