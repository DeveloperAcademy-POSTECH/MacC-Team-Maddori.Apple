//
//  MyReflectionDetailViewController.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2022/11/06.
//

import UIKit

import SnapKit

final class MyReflectionDetailViewController: BaseViewController {
    
    private let continueArray = ["test","test2"]
    private let stopArray = ["test3","test4","test5"]
    
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
        label.applyColor(to: "배포 후 3차 스프린트", with: .blue200)
        return label
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyReflectionDetailTableViewCell.self, forCellReuseIdentifier: MyReflectionDetailTableViewCell.className)
        return tableView
    }()
    private lazy var segmentControl: CustomSegmentedControl = {
        let control = CustomSegmentedControl(items: ["Continue", "Stop"])

        let action = UIAction { [weak self] _ in
            self?.didChangeValue(segment: self!.segmentControl)
        }
        control.addAction(action, for: .valueChanged)
        
        return control
    }()
    private let segmentControlView = CustomSegmentedControlView()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func render() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.topPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(SizeLiteral.topPadding)
            $0.leading.trailing.equalToSuperview()
            // FIXME
            $0.bottom.equalToSuperview().inset(150)
        }
        
//        view.addSubview(segmentControlView)
//        segmentControlView.snp.makeConstraints {
//            $0.top.equalTo(tableView.snp.bottom)
//            $0.centerX.equalToSuperview()
//            $0.width.equalTo(240)
//            $0.height.equalTo(40)
//        }
        
        view.addSubview(segmentControl)
        segmentControl.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom)
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
    }
}
