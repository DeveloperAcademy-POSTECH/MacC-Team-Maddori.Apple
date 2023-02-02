//
//  TeamDetailMemberCollectionView.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2023/02/02.
//

import UIKit

import SnapKit

final class TeamDetailMembersView: UIView {
    
    // MARK: - property
    
    private let memberCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        return collectionView
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - func
    
    private func render() {
        self.addSubview(memberCollectionView)
        memberCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension TeamDetailMembersView: UICollectionViewDelegateFlowLayout {
    
}
