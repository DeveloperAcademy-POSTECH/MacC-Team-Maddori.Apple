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
        let input = SelectReflectionMemberViewModel.Input(viewDidLoad: Observable.just(()).asObservable(), viewWillAppear:  rx.sentMessage(#selector(UIViewController.viewWillAppear(_:))).map{ _ in }.asObservable(), didTappedFeedbackDoneButton: selectReflectionMemberView.feedbackDoneButtonTapPublisher)
        return viewModel.transform(from: input)
    }
    
    private func bindView() {
        selectReflectionMemberView.closeButtonTapPublisher
            .subscribe { [weak self] _ in
                self?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        selectReflectionMemberView.memberCollectionViewItemTapPublisher
            .subscribe { [weak self] indexPath in
                self?.selectReflectionMemberView.didSelectItem(item: indexPath.item)
                self?.navigateToInprogressViewController(item: indexPath.item)
            }
            .disposed(by: disposeBag)
    }
    
    private func navigateToInprogressViewController(item: Int) {
            guard let id = self.selectReflectionMemberView.memberList[item].id,
                  let nickname = self.selectReflectionMemberView.memberList[item].nickname else { return }
            
            let viewController = InProgressViewController(memberId: id, memberUsername: nickname, reflectionId: reflectionId)
            self.navigationController?.pushViewController(viewController, animated: true)
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
        
        output.dismiss
            .subscribe { [weak self] _ in
                self?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        output.isReload
            .subscribe { [weak self] _ in
                self?.selectReflectionMemberView.setPreviousStatus()
            }
            .disposed(by: disposeBag)
    }
}
