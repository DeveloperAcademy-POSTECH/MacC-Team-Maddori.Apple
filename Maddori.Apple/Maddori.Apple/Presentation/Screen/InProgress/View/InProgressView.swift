//
//  InProgressView.swift
//  Maddori.Apple
//
//  Created by 이성민 on 12/30/23.
//

import UIKit

import SnapKit

final class InProgressView: UIView, KeywordCollectionViewLayoutProtocol {
    
    typealias Section = NewInProgressViewController.Section
    
    // MARK: - property
    
    // MARK: - ui components
    
    lazy var keywordCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: self.keywordCollectionViewLayout()
    )
    
    // MARK: - init
    
    init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - setup
    
    private func setupLayout() {
        self.addSubview(keywordCollectionView)
        keywordCollectionView.snp.makeConstraints {
            $0.verticalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
    }
}




protocol KeywordCollectionViewLayoutProtocol {
    func keywordCollectionViewLayout() -> UICollectionViewCompositionalLayout
    func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem
}

extension KeywordCollectionViewLayoutProtocol {
    func keywordCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { f, _ in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .estimated(50),
                heightDimension: .absolute(50)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(50)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(10)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            section.contentInsets = .init(top: 15, leading: 24, bottom: 36, trailing: 24)
            section.boundarySupplementaryItems = [createHeader()]
            
            return section
        }
    }
    
    func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(16)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        return header
    }
}
