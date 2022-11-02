//
//  MyFeedbackCollectionView.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/11/02.
//

import UIKit

import SnapKit

final class MyFeedbackCollectionView: UIView {
    
    private enum Size {
        static let horizontalPadding: CGFloat = 24
        static let topSpacing: CGFloat = 20
    }
    
    // MARK: - property
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.init(top: Size.topSpacing,
                                                    left: Size.horizontalPadding,
                                                    bottom: 0,
                                                    right: Size.horizontalPadding)
        return flowLayout
    }()
    private lazy var feedbackCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MyFeedbackCollectionViewCell.self, forCellWithReuseIdentifier: MyFeedbackCollectionViewCell.className)
        collectionView.register(MyFeedbackHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MyFeedbackHeaderView.className)
        return collectionView
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func render() {
        self.addSubview(feedbackCollectionView)
        feedbackCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

    // MARK: - extension

extension MyFeedbackCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyFeedbackHeaderView.className, for: indexPath) as? MyFeedbackHeaderView else { return UICollectionReusableView() }
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return header
        default:
            return UICollectionReusableView()
        }
    }
}
extension MyFeedbackCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyFeedbackCollectionViewCell.className, for: indexPath) as? MyFeedbackCollectionViewCell else { return UICollectionViewCell()}
        return cell
    }
}

extension MyFeedbackCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 300, height: 40)
    }
}


