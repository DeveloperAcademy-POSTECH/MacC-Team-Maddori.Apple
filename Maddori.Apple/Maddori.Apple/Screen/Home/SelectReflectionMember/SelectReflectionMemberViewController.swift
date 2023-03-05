//
//  SelectFeedbackMemberViewController.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/10/25.
//

import UIKit

import Alamofire
import SnapKit

final class SelectReflectionMemberViewController: BaseViewController {
    
    let reflectionId: Int
    let isAdmin: Bool
    
    // MARK: - property
    
    private lazy var closeButton: CloseButton = {
        let button = CloseButton()
        let action = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private let selectFeedbackMemberTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black100
        label.setTitleFont(text: TextLiteral.selectReflectionMemberViewControllerTitleLabel)
        return label
    }()
    private let memberCollectionView = ReflectionMemberCollectionView()
    private lazy var feedbackDoneButton: MainButton = {
        let button = MainButton()
        let action = UIAction { [weak self] _ in
            guard let reflectionId = self?.reflectionId else { return }
            guard let isAdmin = self?.isAdmin else { return }
            if isAdmin {
                self?.patchEndReflection(type: .patchEndReflection(reflectionId: reflectionId))
            } else {
                self?.dismiss(animated: true)
            }
            UserDefaultHandler.setHasSeenAlert(to: false)
        }
        button.addAction(action, for: .touchUpInside)
        button.isDisabled = true
        return button
    }()
    
    // MARK: - life cycle
    
    init(reflectionId: Int, isAdmin: Bool) {
        self.reflectionId = reflectionId
        self.isAdmin = isAdmin
        super.init()
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didTappedMember()
        fetchTeamMembers(type: .fetchTeamMembers)
        setupPreviousStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupPreviousStatus()
    }
    
    override func render() {
        view.addSubview(selectFeedbackMemberTitleLabel)
        selectFeedbackMemberTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(feedbackDoneButton)
        feedbackDoneButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.bottomPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(memberCollectionView)
        memberCollectionView.snp.makeConstraints {
            $0.top.equalTo(selectFeedbackMemberTitleLabel.snp.bottom).offset(20)
            $0.bottom.equalTo(feedbackDoneButton.snp.top).inset(-6)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let rightButton = makeBarButtonItem(with: closeButton)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = rightButton
    }
    
    private func setupPreviousStatus() {
        feedbackDoneButton.title = TextLiteral.selectReflectionMemberViewControllerDoneButtonText + "(\(UserDefaultStorage.seenMemberIdList.count)/\(memberCollectionView.memberList.count))"
        if UserDefaultStorage.completedCurrentReflection {
            feedbackDoneButton.isDisabled = false
        }
    }
    
    private func didTappedMember() {
        memberCollectionView.didTappedMember = { [weak self] member, members in
            guard let id = member.userId,
                  let username = member.userName,
                  let reflectionId = self?.reflectionId else { return }
            let viewController = InProgressViewController(memberId: id, memberUsername: username, reflectionId: reflectionId)
            self?.navigationController?.pushViewController(viewController, animated: true)
            
            guard let memberCollectionView = self?.memberCollectionView else { return }
            self?.feedbackDoneButton.title = TextLiteral.selectReflectionMemberViewControllerDoneButtonText + "(\( members.count)/\(memberCollectionView.memberList.count))"
            
            if members.count == memberCollectionView.memberList.count {
                self?.feedbackDoneButton.isDisabled = false
                UserDefaultHandler.isCurrentReflectionFinished(true)
            }
        }
    }
    
    // MARK: - api
    // FIXME: - fetchTeamMembers, patchEndReflection v2 api 로 변경하기
    
    private func fetchTeamMembers(type: InProgressEndPoint<VoidModel>) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<MembersResponse>.self) { json in
            if let json = json.value {
                dump(json)
                guard let fetchedMemberList = json.detail?.members else { return }
                DispatchQueue.main.async {
                    self.memberCollectionView.teamMemberList = fetchedMemberList
                    self.feedbackDoneButton.title = TextLiteral.selectReflectionMemberViewControllerDoneButtonText + "(\(self.memberCollectionView.selectedMemberList.count)/\(self.memberCollectionView.memberList.count))"
                }
            }
        }
    }
    
    private func patchEndReflection(type: InProgressEndPoint<VoidModel>) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<ReflectionInfoResponse>.self) { [weak self] json in
            if let _ = json.value {
                self?.dismiss(animated: true)
            }
        }
    }
}
