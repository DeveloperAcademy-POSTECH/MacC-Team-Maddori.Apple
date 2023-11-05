//
//  InvitationCodeViewModel.swift
//  Maddori.Apple
//
//  Created by 이성호 on 11/3/23.
//

import Foundation

import RxSwift

final class InvitationCodeViewModel: BaseViewModelType {
    
    struct Input {
        let viewDidLoad: Observable<Void>
    }
    
    struct Output {
        let code: Observable<String>
    }
    
    // MARK: - property
    
    let invitationCode: String
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - init
    
    init(invitationCode: String) {
        self.invitationCode = invitationCode
    }
    
    // MARK: - public func
    
    func transform(from input: Input) -> Output {
        let code = input.viewDidLoad
            .compactMap { [weak self] in self?.invitationCode }
            
        return Output(code: code)
    }
}
