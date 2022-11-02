//
//  MyBoxViewController.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/02.
//

import UIKit

import SnapKit

final class MyBoxViewController: BaseViewController {
    
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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MyBoxMemberCollectionViewCell.self, forCellWithReuseIdentifier: MyBoxMemberCollectionViewCell.className)
        return collectionView
    }()
    
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
    }
}

// MARK: - extension

extension MyBoxViewController: UICollectionViewDelegate {
    
}

extension MyBoxViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyBoxMemberCollectionViewCell.className, for: indexPath) as? MyBoxMemberCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}
