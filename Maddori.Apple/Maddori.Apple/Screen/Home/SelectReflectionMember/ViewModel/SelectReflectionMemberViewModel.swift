//
//  SelectReflectionMemberViewModel.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2023/12/20.
//

import Foundation

import RxSwift
import Alamofire

final class SelectReflectionMemberViewModel: ViewModelType {
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let didTappedFeedbackDoneButton: Observable<Void>
    }
    
    struct Output {
        let reflectionId: Observable<Int>
        let teamMembers: Observable<[MemberDetailResponse]>
        let dismiss: Observable<Void>
    }
    
    // MARK: - property
    
    private let reflectionId: Int
    
    // MARK: - init
    
    init(reflectionId: Int) {
        self.reflectionId = reflectionId
    }
    
    // MARK: - public func
    
    func transform(from input: Input) -> Output {
        let reflectionId = input.viewDidLoad
            .withUnretained(self)
            .compactMap { _ in self.reflectionId }
        
        let teamMembers = input.viewDidLoad
            .withUnretained(self)
            .flatMap { _ in
                Observable.create { observer in
                    self.fetchTeamMembers(type: .fetchTeamMembers) { teamMembers in
                        if let teamMembers = teamMembers {
                            observer.onNext(teamMembers)
                            observer.onCompleted()
                        }
                    }
                    return Disposables.create()
                }
            }
        
        let dismiss = input.didTappedFeedbackDoneButton
            .withUnretained(self)
            .map { _ in
                self.patchEndReflection(type: .patchEndReflection(reflectionId: self.reflectionId)) {
                    return
                }
            }
        
        return Output(reflectionId: reflectionId, teamMembers: teamMembers, dismiss: dismiss)
    }
    
    // MARK: - private func
    
    private func fetchTeamMembers(type: InProgressEndPoint<VoidModel>, completion: @escaping ([MemberDetailResponse]?) -> Void) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<MembersDetailResponse>.self) { json in
            switch json.result {
            case .success(let response):
                if let fetchedMemberList = response.detail?.members {
                    dump(response)
                    completion(fetchedMemberList)
                }
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    private func patchEndReflection(type: InProgressEndPoint<VoidModel>, completion: @escaping () -> ()) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<ReflectionInfoResponse>.self) { json in
            if let json = json.value {
                dump(json)
                UserDefaultHandler.setHasSeenAlert(to: false)
                completion()
            }
        }
    }
}
