//
//  SelectFeedbackMemberViewController.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/10/25.
//

import UIKit

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
    
    override func loadView() {
        view = selectReflectionMemberView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        bindViewModel()
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
        let input = SelectReflectionMemberViewModel.Input(
            viewDidLoad: self.rx.viewDidLoad,
            feedbackDoneButtonTapped: selectReflectionMemberView.feedbackDoneButtonTapPublisher
        )
        return viewModel.transform(from: input)
    }
    
    private func bindView() {
        selectReflectionMemberView.closeButtonTapPublisher
            .subscribe { [weak self] _ in
                self?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        self.rx.viewWillAppear
            .subscribe { [weak self] _ in
                self?.selectReflectionMemberView.setPreviousStatus()
            }
            .disposed(by: disposeBag)
    }
    
    private func navigateToInprogressViewController(reflectionId: Int, memberInfo: MemberInfo) {
        let viewController = InProgressViewController(memberId: memberInfo.id, memberUsername: memberInfo.nickname, reflectionId: reflectionId)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - bind

extension SelectReflectionMemberViewController {
    private func bind(output: SelectReflectionMemberViewModel.Output?) {
        guard let output else { return }
        
        let reflectionId = output.reflectionId
        let memberInfo = selectReflectionMemberView.memberInfoPublisher
        
        Observable.combineLatest(reflectionId, memberInfo)
            .subscribe { [weak self] reflectionId, memberInfo in
                self?.navigateToInprogressViewController(reflectionId: reflectionId, memberInfo: memberInfo)
            }
            .disposed(by: disposeBag)
        
        output.teamMembers
            .subscribe { [weak self] teamMembers in
                self?.selectReflectionMemberView.setTeamMembers(teamMembers: teamMembers)
            }
            .disposed(by: disposeBag)
        
        output.reflectionDidEnd
            .subscribe { [weak self] _ in
                self?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
}
