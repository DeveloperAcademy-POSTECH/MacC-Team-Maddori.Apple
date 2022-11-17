//
//  MyReflectionDetailViewController.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2022/11/06.
//

import UIKit

import Alamofire
import SnapKit

final class MyReflectionDetailViewController: BaseViewController {
    
    // FIXME - 데이터 연결시 수정예정
    private let continueArray = ["c1","c"]
    private let stopArray = ["s","s","s"]
    
    private lazy var contentArray = continueArray
    
    // MARK: - property
    
    private lazy var backButton: BackButton = {
        let button = BackButton(type: .system)
        let action = UIAction { [weak self] _ in
            // FIXME
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        // FIXME
        label.setTitleFont(text: "배포 후 3차 스프린트를 돌아보세요")
        label.textColor = .black100
        label.applyColor(to: "배포 후 3차 스프린트", with: .blue200)
        return label
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .backgroundWhite
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyReflectionDetailTableViewCell.self, forCellReuseIdentifier: MyReflectionDetailTableViewCell.className)
        return tableView
    }()
    private lazy var segmentControl: CustomSegmentControl = {
        let control = CustomSegmentControl(items: ["Continue", "Stop"])
        let action = UIAction { [weak self] _ in
            if let segment = self?.segmentControl {
                self?.didChangeValue(segment: segment)
            }
        }
        control.addAction(action, for: .valueChanged)
        return control
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // FIXME: reflectionId, CssType 받아오기
        fetchCertainTypeFeedbackAll(type: .fetchCertainTypeFeedbackAllID(teamId: UserDefaultStorage.teamId, userId: UserDefaultStorage.userID, reflectionId: 3, cssType: "Continue"))
    }
    
    override func render() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview()
            // FIXME
            $0.bottom.equalToSuperview()
        }
        
        tableView.addSubview(segmentControl)
        segmentControl.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(240)
            $0.height.equalTo(40)
        }
    }
    
    // MARK: - func
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let button = removeBarButtonItemOffset(with: backButton, offsetX: 10)
        let backButton = makeBarButtonItem(with: button)
        
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func didChangeValue(segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            contentArray = continueArray
        }
        else {
            contentArray = stopArray
        }
        tableView.reloadData()
    }
    
    // MARK: - api
    
    private func fetchCertainTypeFeedbackAll(type: MyReflectionEndPoint<EncodeDTO>) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<AllCertainTypeFeedBackResponse>.self) { json in
            if let json = json.value {
                
            } else {
                
            }
            print(json.response?.statusCode)
        }
    }
    
    // MARK: - setup
    
    private func setupBackButton() {
        let action = UIAction { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        backButton.addAction(action, for: .touchUpInside)
    }
}

extension MyReflectionDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // FIXME
        return contentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyReflectionDetailTableViewCell.className, for: indexPath) as? MyReflectionDetailTableViewCell else { return UITableViewCell() }
        
        // FIXME
        cell.titleLabel.text = "필기능력"
        return cell
    }
}

extension MyReflectionDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(MyReflectionFeedbackViewController(), animated: true)
    }
}
