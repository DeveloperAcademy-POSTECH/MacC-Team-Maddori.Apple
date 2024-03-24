//
//  MyBoxViewController.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/02.
//

import UIKit

import Alamofire
import SnapKit

final class MyFeedbackViewController: BaseViewController {
    var selectedIndex: Int = 0
    private var memberList: [MemberDetailResponse] = [] {
        didSet {
            removeChildViews()
            if memberList.isEmpty {
                setLayoutEmptyView()
            } else {
                setLayoutMyFeedbackView()
                memberCollectionView.reloadData()
                fetchCertainMemberFeedBack(type: .fetchCertainMemberFeedBack(memberId: memberList[selectedIndex].id ?? 0))
            }
        }
    }
    
    private enum Size {
        static let horizontalPadding: CGFloat = 24
        static let verticalPadding: CGFloat = 20
        static let cellSize: CGFloat = 60
        static let minimumLineSpacing: CGFloat = 16
    }
    
    // MARK: - property
    
    private let myFeedbackLabel: UILabel = {
        let label = UILabel()
        label.setTitleFont(text: TextLiteral.myFeedbackViewControllerTitleLabel)
        return label
    }()
    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: Size.verticalPadding,
                                               left: Size.horizontalPadding,
                                               bottom: Size.verticalPadding,
                                               right: Size.horizontalPadding)
        flowLayout.itemSize = CGSize(width: Size.cellSize, height: Size.cellSize + 20)
        flowLayout.minimumLineSpacing = Size.minimumLineSpacing
        return flowLayout
    }()
    private lazy var memberCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .backgroundWhite
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MyFeedbackMemberCollectionViewCell.self, forCellWithReuseIdentifier: MyFeedbackMemberCollectionViewCell.className)
        collectionView.accessibilityIdentifier = "removableView"
        return collectionView
    }()
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray300
        return view
    }()
    private lazy var feedbackCollectionView: MyFeedbackCollectionView = {
        let collectionView = MyFeedbackCollectionView()
        collectionView.didTappedCell = { [weak self] data in
            let data = FeedbackFromMeModel(reflectionId: data.reflectionId,
                                           feedbackId: data.feedbackId,
                                           nickname: data.nickname,
                                           feedbackType: data.feedbackType,
                                           keyword: data.keyword,
                                           info: data.info,
                                           reflectionStatus: data.reflectionStatus
            )
            self?.navigationController?.pushViewController(MyFeedbackDetailViewController(feedbackDetail: data), animated: true)
        }
        collectionView.accessibilityIdentifier = "removableView"
        return collectionView
    }()
    private lazy var emptyView: EmptyPersonView = {
        let view = EmptyPersonView()
        view.accessibilityIdentifier = "removableView"
        return view
    }()
    
    // MARK: - life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCurrentTeamMember(type: .fetchCurrentTeamMember)
        print(UserDefaultStorage.teamId)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func render() {
        view.addSubview(myFeedbackLabel)
        myFeedbackLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
    }
    
    // MARK: - func
    
    private func setLayoutMyFeedbackView() {
        view.addSubview(myFeedbackLabel)
        myFeedbackLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(memberCollectionView)
        memberCollectionView.snp.makeConstraints {
            $0.top.equalTo(myFeedbackLabel.snp.bottom).offset(7)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        view.addSubview(dividerView)
        dividerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(memberCollectionView.snp.bottom)
            $0.height.equalTo(0.5)
        }
        
        view.addSubview(feedbackCollectionView)
        feedbackCollectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(dividerView.snp.bottom)
        }
    }
    
    private func setLayoutEmptyView() {
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints {
            $0.top.equalTo(myFeedbackLabel.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func removeChildViews() {
        let removableView = self.view.subviews.filter {
            $0.accessibilityIdentifier == "removableView"
        }
        removableView.forEach {
            $0.removeFromSuperview()
        }
    }
    
    // MARK: - api
    
    private func fetchCurrentTeamMember(type: MyFeedBackEndPoint<VoidModel>) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<MembersDetailResponse>.self) { [weak self] json in
            if let data = json.value {
                var memberArray: [MemberDetailResponse] = []
                guard let members = json.value?.detail?.members else { return }
                members.forEach {
                    if $0.nickname != UserDefaultStorage.nickname {
                        memberArray.append($0)
                    }
                }
                self?.memberList = memberArray
                dump(data)
            }
        }
    }
    
    private func fetchCertainMemberFeedBack(type: MyFeedBackEndPoint<VoidModel>) {
        AF.request(type.address,
                   method: .get,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<FeedBackInfoResponse>.self) { [weak self] json in
            if let data = json.value {
                guard let detail = data.detail else { return }
                self?.feedbackCollectionView.feedbackInfo = detail
                dump(data)
            }
        }
    }
}

// MARK: - extension

extension MyFeedbackViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let memberId = memberList[indexPath.item].id else { return }
        fetchCertainMemberFeedBack(type: .fetchCertainMemberFeedBack(memberId: memberId))
        selectedIndex = indexPath.item
    }
}

extension MyFeedbackViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        memberList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyFeedbackMemberCollectionViewCell.className, for: indexPath) as? MyFeedbackMemberCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setMemberName(name: memberList[indexPath.item].nickname ?? "")
        cell.setMemberProfileImage(from: memberList[indexPath.item].profileImagePath)
        if indexPath.item == selectedIndex {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        }
        return cell
    }
}
