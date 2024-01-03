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
        let viewWillAppear: Observable<Void>
        let feedbackDoneButtonTapped: Observable<Void>
        let memberItemTapped: Observable<MemberInfo>
    }
    
    struct Output {
        let reflectionId: Observable<Int>
        let reflectionStateAtViewDidLoad: Observable<ReflectionState>
        let teamMembers: Observable<[MemberDetailResponse]>
        let reflectionStateAtViewWillAppear: Observable<ReflectionState>
        let reflectionDidEnd: Observable<Void>
    }
    
    // MARK: - property
    
    private let reflectionId: Int
    private var numOfTotalMembers: Int = 0
    
    // MARK: - init
    
    init(reflectionId: Int) {
        self.reflectionId = reflectionId
    }
    
    // MARK: - public func
    
    func transform(from input: Input) -> Output {
        let reflectionId = input.viewDidLoad
            .withUnretained(self)
            .compactMap { _ in self.reflectionId }
        
        let reflectionStateAtViewDidLoad = input.viewDidLoad
            .map { _ in ReflectionState(seenMemberList: UserDefaultStorage.seenMemberIdList, numOfSeenMember: UserDefaultStorage.seenMemberIdList.count, completedCurrentReflection: UserDefaultStorage.completedCurrentReflection) }
        
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
        
        let reflectionStateAtViewWillAppear = input.viewWillAppear
            .map { _ in ReflectionState(seenMemberList: UserDefaultStorage.seenMemberIdList, numOfSeenMember: UserDefaultStorage.seenMemberIdList.count, completedCurrentReflection: UserDefaultStorage.completedCurrentReflection) }
        
        let reflectionDidEnd = input.feedbackDoneButtonTapped
            .withUnretained(self)
            .map { _ in
                self.patchEndReflection(type: .patchEndReflection(reflectionId: self.reflectionId)) {
                    return
                }
            }
        
        _ = input.memberItemTapped
            .withUnretained(self)
            .subscribe { _, memberInfo in
                self.updateReflectionStatus(id: memberInfo.id)
            }
        
        return Output(reflectionId: reflectionId,
                      reflectionStateAtViewDidLoad: reflectionStateAtViewDidLoad,
                      teamMembers: teamMembers,
                      reflectionStateAtViewWillAppear: reflectionStateAtViewWillAppear,
                      reflectionDidEnd: reflectionDidEnd)
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
                    self.numOfTotalMembers = fetchedMemberList.count
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
    
    private func updateReflectionStatus(id: Int) {
        let selectMemberSet = Set(UserDefaultStorage.seenMemberIdList + [id])
        UserDefaultHandler.appendSeenMemberIdList(memberIdList: Array(selectMemberSet))
        
        UserDefaultHandler.isCurrentReflectionFinished(UserDefaultStorage.seenMemberIdList.count == numOfTotalMembers)
    }
}
