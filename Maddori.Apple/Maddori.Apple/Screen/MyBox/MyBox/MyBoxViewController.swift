//
//  MyBoxViewController.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/02.
//

import UIKit

import SnapKit

final class MyBoxViewController: BaseViewController {
    private let memberList: [String] = Member.getTotalMemberList()
    
    private enum Size {
        static let horizontalPadding: CGFloat = 24
        static let verticalPadding: CGFloat = 20
        static let cellSize: CGFloat = 60
        static let minimumLineSpacing: CGFloat = 16
    }
    
    // MARK: - property
    
    private let myFeedbackLabel: UILabel = {
        let label = UILabel()
        label.setTitleFont(text: TextLiteral.myBoxViewControllerTitleLabel)
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
        collectionView.register(MyBoxMemberCollectionViewCell.self, forCellWithReuseIdentifier: MyBoxMemberCollectionViewCell.className)
        return collectionView
    }()
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray300
        return view
    }()
    private let feedbackCollectionView = MyFeedbackCollectionView()
    
    // MARK: - life cycle
    
    override func render() {
        view.addSubview(myFeedbackLabel)
        myFeedbackLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
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
}

// MARK: - extension

extension MyBoxViewController: UICollectionViewDelegate { }

extension MyBoxViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        memberList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyBoxMemberCollectionViewCell.className, for: indexPath) as? MyBoxMemberCollectionViewCell else {
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
