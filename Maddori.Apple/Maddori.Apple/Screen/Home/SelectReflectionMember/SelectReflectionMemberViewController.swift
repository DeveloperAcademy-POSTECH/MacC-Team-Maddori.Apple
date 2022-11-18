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
        
    // MARK: - property
    
    private let closeButton = CloseButton(type: .system)
    private let selectFeedbackMemberTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black100
        label.setTitleFont(text: TextLiteral.selectReflectionMemberViewControllerTitleLabel)
        return label
    }()
    private let memberCollectionView: MemberCollectionView = {
        let collectionView = MemberCollectionView()
        collectionView.memberList = Member.getTotalMemberList()
        return collectionView
    }()
    private lazy var feedbackDoneButton: MainButton = {
        let button = MainButton()
        button.title = TextLiteral.selectReflectionMemberViewControllerDoneButtonText + "(0/\(memberCollectionView.memberList.count))"
        button.isDisabled = true
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didTappedMember()
        fetchTeamMembers(type: .fetchTeamMembers(teamId: 63, userId: 122))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    private func fetchTeamMembers(type: InProgressEndPoint) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<TeamMembersResponse>.self) { json in
            if let json = json.value {
                dump(json)
                var memberList: [String] = []
                // FIXME: - username이 바깥으로 빠지면 코드 변경 필요
                guard let fetchedMemberList = json.detail?.members else { return }
                for member in fetchedMemberList {
                    guard let username = member.username else { return }
                    memberList.append(username)
                }
                DispatchQueue.main.async {
                    self.memberCollectionView.memberList = memberList
                    self.memberCollectionView.collectionView.reloadData()
                }
            }
        }
    }
}
