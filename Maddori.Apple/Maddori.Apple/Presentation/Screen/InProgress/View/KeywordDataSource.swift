//
//  KeywordDataSource.swift
//  Maddori.Apple
//
//  Created by 이성민 on 12/31/23.
//

import UIKit

final class KeywordDataSource<Section: Hashable & Sendable & CaseIterable & RawRepresentable> {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, FeedbackInfo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, FeedbackInfo>
    
    typealias Cell = NewKeywordCollectionViewCell
    typealias CellRegistration = UICollectionView.CellRegistration<Cell, FeedbackInfo>
    
    typealias Header = KeywordCollectionViewHeader
    typealias HeaderRegistration = UICollectionView.SupplementaryRegistration<Header>
    
    // MARK: - property
    
    let collectionView: UICollectionView
    let hasHeader: Bool
    
    var dataSource: DataSource!
    var snapshot: Snapshot!
    
    // MARK: - init
    
    init(collectionView: UICollectionView, hasHeader: Bool) {
        self.collectionView = collectionView
        self.hasHeader = hasHeader
        self.setupDataSource()
        self.setupSnapshot()
    }
    
    // MARK: - setup
    
    private func setupDataSource() {
        self.configureCell()
        if hasHeader { self.configureHeader() }
    }
    
    private func setupSnapshot() {
        self.snapshot = Snapshot()
        
        let sections = Array(Section.allCases)
        self.snapshot.appendSections(sections)
        self.dataSource.apply(self.snapshot)
    }
}

// MARK: - configure dataSource

extension KeywordDataSource {
    private func configureCell() {
        let cellRegistration = CellRegistration { cell, _, feedback in
            cell.configureLabel(text: feedback.keyword)
            cell.configureUI(type: .main)
        }
        
        self.dataSource = DataSource(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, feedback in
            return self.collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: feedback
            )
        })
    }
    
    private func configureHeader() {
        let headerRegistration = HeaderRegistration(
            elementKind: UICollectionView.elementKindSectionHeader
        ) { header, _, indexPath in
            let titles = Section.allCases.map { String(describing: $0.rawValue) }
            header.configureLabel(text: titles[indexPath.section] )
        }
        
        self.dataSource.supplementaryViewProvider = { _, _, indexPath in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration,
                for: indexPath
            )
        }
    }
}

// MARK: - configure snapshot

extension KeywordDataSource {
    func loadSnapshot(with feedbacks: [FeedbackInfo]) {
        self.snapshot.appendItems(feedbacks)
        self.dataSource.apply(self.snapshot)
    }
}
