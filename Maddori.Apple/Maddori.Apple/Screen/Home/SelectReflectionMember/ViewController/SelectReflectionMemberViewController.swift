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
    
    private var reflectionId: Int = 0
    private let selectReflectionMemberView = SelectReflectionMemberView()
    
    private let viewModel: any ViewModelType
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - life cycle
    
    init(viewModel: any ViewModelType) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        bindViewModel()
        didTappedMember()
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
    
    private func bindViewModel() {
        let output = transformInput()
        bind(output: output)
    }
    
    private func transformInput() -> SelectReflectionMemberViewModel.Output? {
        guard let viewModel = viewModel as? SelectReflectionMemberViewModel else { return nil }
        let input = SelectReflectionMemberViewModel.Input(viewDidLoad: Observable.just(()).asObservable())
        return viewModel.transform(from: input)
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
        
        selectReflectionMemberView.memberCollectionView
            .rx
            .itemSelected
            .subscribe{ indexPath in
                print("look at this code", indexPath, indexPath.item)
//                self.navigateToInProgressViewController
            }
            .disposed(by: disposeBag)
    }
        
    private func setupPreviousStatus() {
        selectReflectionMemberView.setupPreviousStatus()
    }
    
    private func didTappedMember() {
        selectReflectionMemberView.didTappedMember = { [weak self] member, members in
            guard let id = member.id,
                  let nickname = member.nickname,
                  let reflectionId = self?.reflectionId else { return }
            let viewController = InProgressViewController(memberId: id, memberUsername: nickname, reflectionId: reflectionId)
            self?.navigationController?.pushViewController(viewController, animated: true)
            
            guard let memberCollectionView = self?.selectReflectionMemberView else { return }
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

// MARK: - bind

extension SelectReflectionMemberViewController {
    private func bind(output: SelectReflectionMemberViewModel.Output?) {
        guard let output else { return }
        
        output.reflectionId
            .subscribe { [weak self] reflectionId in
                self?.reflectionId = reflectionId
            }
            .disposed(by: disposeBag)
        
        output.teamMembers
            .subscribe { [weak self] teamMembers in
                self?.selectReflectionMemberView.setTeamMembers(teamMembers: teamMembers)
            }
            .disposed(by: disposeBag)
    }
}
