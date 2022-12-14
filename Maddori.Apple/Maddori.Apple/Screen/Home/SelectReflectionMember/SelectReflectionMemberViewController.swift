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
    
    init(reflectionId: Int, isAdmin: Bool) {
        self.reflectionId = reflectionId
        self.isAdmin = isAdmin
        print("reflectionId: \(reflectionId)")
        super.init()
    }
    
    required init?(coder: NSCoder) { nil }
    
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
    private lazy var memberCollectionView: MemberCollectionView = {
        let collectionView = MemberCollectionView(type: .progressReflection)
        collectionView.didTappedFeedBackMember = { [weak self] _ in
            let member = collectionView.selectedMember
            guard let id = member?.userId,
                  let username = member?.userName,
                  let reflectionId = self?.reflectionId
            else { return }
            let viewController = InProgressViewController(memberId: id, memberUsername: username, reflectionId: reflectionId)
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
        return collectionView
    }()
    private lazy var feedbackDoneButton: MainButton = {
        let button = MainButton()
        let action = UIAction { [weak self] _ in
            guard let reflectionId = self?.reflectionId else { return }
            UserDefaultHandler.setHasSeenAlert(to: false)
            guard let isAdmin = self?.isAdmin else { return }
            if isAdmin {
                self?.patchEndReflection(type: .patchEndReflection(reflectionId: reflectionId))
            } else {
                self?.dismiss(animated: true)
            }
        }
        button.addAction(action, for: .touchUpInside)
        button.isDisabled = true
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didTappedMember()
        fetchTeamMembers(type: .fetchTeamMembers)
    }
    
    override func render() {
        view.addSubview(selectFeedbackMemberTitleLabel)
        selectFeedbackMemberTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(memberCollectionView)
        memberCollectionView.snp.makeConstraints {
            $0.top.equalTo(selectFeedbackMemberTitleLabel.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(feedbackDoneButton)
        feedbackDoneButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.bottomPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
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
    
    private func didTappedMember() {
        memberCollectionView.didTappedMember = { [weak self] member in
            self?.feedbackDoneButton.title = TextLiteral.selectReflectionMemberViewControllerDoneButtonText + "(\(member.count)/\(self?.memberCollectionView.memberList.count ?? 0))"
            if member.count == self?.memberCollectionView.memberList.count {
                self?.feedbackDoneButton.isDisabled = false
            }
        }
    }
    
    // MARK: - api
    
    private func fetchTeamMembers(type: InProgressEndPoint<VoidModel>) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<TeamMembersResponse>.self) { json in
            if let json = json.value {
                guard let fetchedMemberList = json.detail?.members else { return }
                DispatchQueue.main.async {
                    self.memberCollectionView.memberList = fetchedMemberList
                    self.feedbackDoneButton.title = TextLiteral.selectReflectionMemberViewControllerDoneButtonText + "(0/\(self.memberCollectionView.memberList.count))"
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
