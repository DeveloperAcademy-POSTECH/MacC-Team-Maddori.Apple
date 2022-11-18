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
    private let memberList: [String] = Member.getMemberListExceptUser()
    
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
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: Size.verticalPadding,
                                               left: Size.horizontalPadding,
                                               bottom: Size.verticalPadding,
                                               right: Size.horizontalPadding)
        flowLayout.itemSize = CGSize(width: Size.cellSize, height: Size.cellSize)
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
        return collectionView
    }()
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray300
        return view
    }()
    private lazy var feedbackCollectionView: MyFeedbackCollectionView = {
        let collectionView = MyFeedbackCollectionView()
        // FIXME: - index로 해당 배열값 넘겨주기
        collectionView.didTappedCell = { [weak self] index in
            self?.navigationController?.pushViewController(MyFeedbackDetailViewController(), animated: true)
        }
        return collectionView
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCurrentTeamMember(type: .fetchCurrentTeamMember(teamId: 1, userId: 1))
        fetchCertainMemberFeedBack(type: .fetchCertainMemberFeedBack(teamId: 1, memberId: 2, userId: 1))
    }
    
    override func render() {
        view.addSubview(myFeedbackLabel)
        myFeedbackLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(memberCollectionView)
        memberCollectionView.snp.makeConstraints {
            $0.top.equalTo(myFeedbackLabel.snp.bottom).offset(7)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
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
    
    // MARK: - api
    
    private func fetchCurrentTeamMember(type: MyFeedBackEndPoint<VoidModel>) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<TeamMembersResponse>.self) { json in
            if let data = json.value {
                // FIXME: - memberList에 데이터 넣기
                dump(data)
            }
        }
    }
    
    private func fetchCertainMemberFeedBack(type: MyFeedBackEndPoint<VoidModel>) {
        AF.request(type.address,
                   method: .get,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<FeedBackInfoResponse>.self) { json in
            if let data = json.value {
                // FIXME: - collectionView에 데이터 전달
                dump(data)
            }
        }
    }
}

// MARK: - extension

extension MyFeedbackViewController: UICollectionViewDelegate { }

extension MyFeedbackViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        memberList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyFeedbackMemberCollectionViewCell.className, for: indexPath) as? MyFeedbackMemberCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setMemberName(name: memberList[indexPath.item])
        if indexPath.item == 0 {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        }
        return cell
    }
}
