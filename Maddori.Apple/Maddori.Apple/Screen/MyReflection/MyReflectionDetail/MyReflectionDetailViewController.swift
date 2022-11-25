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
    
    private var reflectionName: String
    private let reflectionId: Int
    private var contentArray: [FeedBackResponse] = []
    
    // MARK: - property
    
    private lazy var backButton: BackButton = {
        let button = BackButton(type: .system)
        let action = UIAction { [weak self] _ in
            // FIXME
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black100
        label.setTitleFont(text: reflectionName + "를\n돌아보세요")
        label.applyColor(to: reflectionName, with: .blue200)
        return label
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .backgroundWhite
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyReflectionDetailTableViewCell.self, forCellReuseIdentifier: MyReflectionDetailTableViewCell.className)
        tableView.register(EmptyTableFeedbackView.self, forCellReuseIdentifier: EmptyTableFeedbackView.className)
        return tableView
    }()
    private lazy var segmentControl: CustomSegmentControl = {
        let control = CustomSegmentControl(items: [FeedBackDTO.continueType.rawValue, FeedBackDTO.stopType.rawValue])
        let action = UIAction { [weak self] _ in
            if let segment = self?.segmentControl {
                self?.didChangeValue(segment: segment)
            }
        }
        control.addAction(action, for: .valueChanged)
        return control
    }()
    
    // MARK: - life cycle
    
    init(reflectionId: Int, reflectionName: String) {
        self.reflectionId = reflectionId
        self.reflectionName = reflectionName
        super.init()
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
        fetchCertainTypeFeedbackAll(type: .fetchCertainTypeFeedbackAllID(reflectionId: reflectionId, cssType: .continueType))
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
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
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
            fetchCertainTypeFeedbackAll(type: .fetchCertainTypeFeedbackAllID(reflectionId: reflectionId, cssType: .continueType))
        }
        else {
            fetchCertainTypeFeedbackAll(type: .fetchCertainTypeFeedbackAllID(reflectionId: reflectionId, cssType: .stopType))
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
                guard let jsonDetail = json.detail else { return }
                self.contentArray = jsonDetail.feedback
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
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
        return contentArray.isEmpty ? 1 : contentArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if contentArray.isEmpty {
            guard let emptyCell = tableView.dequeueReusableCell(withIdentifier: EmptyTableFeedbackView.className, for: indexPath) as? EmptyTableFeedbackView else { return UITableViewCell() }
            emptyCell.emptyFeedbackLabel.text = TextLiteral.emptyViewMyReflectionDetail
            emptyCell.isUserInteractionEnabled = false
            tableView.separatorStyle = .none
            tableView.isScrollEnabled = false
            return emptyCell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyReflectionDetailTableViewCell.className, for: indexPath) as? MyReflectionDetailTableViewCell else { return UITableViewCell() }
            if indexPath.row == contentArray.count {
                cell.rightImage.isHidden = true
                cell.fromLabelBackView.isHidden = true
                cell.isUserInteractionEnabled = false
                return cell
            } else {
                guard let keyword = contentArray[indexPath.row].keyword,
                      let fromLabelText = contentArray[indexPath.row].fromUser?.userName,
                      let content = contentArray[indexPath.row].content else { return UITableViewCell() }
                cell.configLabel(title: keyword, fromLabel: fromLabelText, content: content)
                tableView.isScrollEnabled = true
                return cell
            }
        }
    }
}

extension MyReflectionDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if contentArray.isEmpty {
            return tableView.frame.height - 90
        } else if indexPath.row == contentArray.count {
            return 44
        }
        else {
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(MyReflectionFeedbackViewController(model: contentArray[indexPath.row]), animated: true)
    }
}
