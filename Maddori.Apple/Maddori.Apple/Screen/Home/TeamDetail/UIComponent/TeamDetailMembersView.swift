//
//  TeamDetailMemberCollectionView.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2023/02/02.
//

import UIKit

import SnapKit

final class TeamDetailMembersView: UIView {
    
    private let cellWidth = UIScreen.main.bounds.width - (SizeLiteral.leadingTrailingPadding * 2)
    
    // MARK: - property
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: cellWidth, height: 46)
        flowLayout.minimumLineSpacing = 20
        return flowLayout
    }()
    private lazy var memberCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(TeamDetailMembersCell.self, forCellWithReuseIdentifier: TeamDetailMembersCell.className)
        return collectionView
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        setupDelegation()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - func
    
    private func render() {
        self.addSubview(memberCollectionView)
        memberCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupDelegation() {
        memberCollectionView.delegate = self
        memberCollectionView.dataSource = self
    }
}

extension TeamDetailMembersView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // FIXME: - 임시 확인 값
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamDetailMembersCell.className, for: indexPath) as? TeamDetailMembersCell else { return UICollectionViewCell() }
        return cell
    }
}

extension TeamDetailMembersView: UICollectionViewDelegate {
    
}
