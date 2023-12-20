//
//  SelectFeedbackMemberViewController.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/10/25.
//

import UIKit

import Alamofire
import RxSwift

final class SelectReflectionMemberViewController: BaseViewController {
    
    // MARK: - property
    
    let reflectionId: Int
    private let selectReflectionMemberView = SelectReflectionMemberView()
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - life cycle
    
    init(reflectionId: Int) {
        self.reflectionId = reflectionId
        super.init()
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        didTappedMember()
        fetchTeamMembers(type: .fetchTeamMembers)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupPreviousStatus()
    }
    
    override func loadView() {
        view = selectReflectionMemberView
    }
    
    // MARK: - override
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        configureNavigationController()
    }
    
    // MARK: - private func
    
    private func configureNavigationController() {
        guard let navigationController else { return }
        selectReflectionMemberView.setupNavigationController(navigationController)
        selectReflectionMemberView.setupNavigationItem(navigationItem)
    }
    
    private func bindView() {
        selectReflectionMemberView.closeButtonTapPublisher
            .subscribe { [weak self] _ in
                self?.didTappedCloseButton()
            }
            .disposed(by: disposeBag)
        
        selectReflectionMemberView.feedbackDoneButtonTapPublisher
            .subscribe { [weak self] _ in
                self?.didTappedFeedbackDoneButton()
            }
            .disposed(by: disposeBag)
    }
        
    private func setupPreviousStatus() {
        selectReflectionMemberView.feedbackDoneButton.title = TextLiteral.selectReflectionMemberViewControllerDoneButtonText + "(\(UserDefaultStorage.seenMemberIdList.count)/\(selectReflectionMemberView.memberCollectionView.memberList.count))"
        selectReflectionMemberView.feedbackDoneButton.isDisabled = !UserDefaultStorage.completedCurrentReflection
    }
    
    private func didTappedMember() {
        selectReflectionMemberView.memberCollectionView.didTappedMember = { [weak self] member, members in
            guard let id = member.id,
                  let nickname = member.nickname,
                  let reflectionId = self?.reflectionId else { return }
            let viewController = InProgressViewController(memberId: id, memberUsername: nickname, reflectionId: reflectionId)
            self?.navigationController?.pushViewController(viewController, animated: true)
            
            guard let memberCollectionView = self?.selectReflectionMemberView.memberCollectionView else { return }
            self?.selectReflectionMemberView.feedbackDoneButton.title = TextLiteral.selectReflectionMemberViewControllerDoneButtonText + "(\( members.count)/\(memberCollectionView.memberList.count))"
            
            if members.count == memberCollectionView.memberList.count {
                self?.selectReflectionMemberView.feedbackDoneButton.isDisabled = false
                UserDefaultHandler.isCurrentReflectionFinished(true)
            }
        }
    }
    
    private func didTappedCloseButton() {
        self.dismiss(animated: true)
    }
    
    private func didTappedFeedbackDoneButton() {
        self.patchEndReflection(type: .patchEndReflection(reflectionId: self.reflectionId))
        UserDefaultHandler.setHasSeenAlert(to: false)
    }
    
    // MARK: - api
    
    private func fetchTeamMembers(type: InProgressEndPoint<VoidModel>) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<MembersDetailResponse>.self) { json in
            if let json = json.value {
                dump(json)
                guard let fetchedMemberList = json.detail?.members else { return }
                DispatchQueue.main.async {
                    self.selectReflectionMemberView.memberCollectionView.memberList = fetchedMemberList
                    self.selectReflectionMemberView.feedbackDoneButton.title = TextLiteral.selectReflectionMemberViewControllerDoneButtonText + "(\(self.selectReflectionMemberView.memberCollectionView.selectedMemberList.count)/\(self.selectReflectionMemberView.memberCollectionView.memberList.count))"
                }
            }
        }
    }
    
    private func patchEndReflection(type: InProgressEndPoint<VoidModel>) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<ReflectionInfoResponse>.self) { [weak self] json in
            if let json = json.value {
                dump(json)
                self?.dismiss(animated: true)
            }
        }
    }
}
