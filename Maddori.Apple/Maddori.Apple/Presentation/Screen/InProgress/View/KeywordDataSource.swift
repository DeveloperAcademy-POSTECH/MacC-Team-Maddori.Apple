//
//  KeywordDataSource.swift
//  Maddori.Apple
//
//  Created by 이성민 on 12/31/23.
//

import UIKit

final class KeywordDataSource {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, FeedbackInfo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, FeedbackInfo>
    
    typealias Cell = NewKeywordCollectionViewCell
    typealias CellRegistration = UICollectionView.CellRegistration<Cell, FeedbackInfo>
    
    typealias Header = KeywordCollectionViewHeader
    typealias HeaderRegistration = UICollectionView.SupplementaryRegistration<Header>
    
    // MARK: - property
    
    enum Usage {
        case inProgressMy
        case inProgressOther
        case home
    }
    
    enum Section: Int, CaseIterable {
        case main
        case sub
        case preview
    }
    
    let collectionView: UICollectionView
    let usage: Usage
    
    var dataSource: DataSource!
    var snapshot: Snapshot!
    
    // MARK: - init
    
    init(collectionView: UICollectionView, usage: Usage) {
        self.collectionView = collectionView
        self.usage = usage
        self.setupDataSource()
        self.setupSnapshot()
    }
    
    // MARK: - setup
    
    private func setupDataSource() {
        self.configureCell()
        self.configureHeader()
    }
    
    private func setupSnapshot() {
        self.snapshot = Snapshot()
        self.dataSource.apply(self.snapshot)
    }
}

// MARK: - configure dataSource

extension KeywordDataSource {
    private func configureCell() {
        let cellRegistration = CellRegistration { cell, indexPath, feedback in
            switch self.usage {
            case .home: cell.configureUI(type: .preview)
            case .inProgressMy, .inProgressOther:
                guard let section = Section(rawValue: indexPath.section)
                else { return }
                
                switch section {
                case .main: cell.configureUI(type: .main)
                case .sub: cell.configureUI(type: .sub)
                default: return
                }
            }
            
            cell.configureLabel(text: feedback.keyword)
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
            switch self.usage {
            case .home: header.configureLabel(text: TextLiteral.KeywordCollection.homeHeader)
            case .inProgressMy: header.configureLabel(text: TextLiteral.KeywordCollection.inProgressMy)
            case .inProgressOther:
                guard let section = Section(rawValue: indexPath.section)
                else { return }
                
                switch section {
                case .main: header.configureLabel(text: TextLiteral.KeywordCollection.inProgressOtherMain)
                case .sub: header.configureLabel(text: TextLiteral.KeywordCollection.inProgressOtherSub)
                default: return
                }
            }
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
    func loadSnapshot(with feedbacks: [FeedbackInfo], to section: Section) {
        self.snapshot.appendSections([section])
        self.snapshot.appendItems(feedbacks, toSection: section)
        self.dataSource.apply(self.snapshot)
    }
}
