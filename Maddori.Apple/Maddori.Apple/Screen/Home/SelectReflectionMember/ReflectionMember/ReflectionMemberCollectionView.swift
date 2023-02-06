//
//  ReflectionMemberCollectionView.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2023/02/06.
//

import UIKit

import SnapKit

final class ReflectionMemberCollectionView: UIView {
    
    private enum Size {
        static let collectionHorizontalSpacing: CGFloat = 34
        static let collectionVerticalSpacing: CGFloat = 20
        static let cellLength: CGFloat = 140
        static let cellInteritemSpacingSpacing: CGFloat = 27
        static let cellLineSpacing: CGFloat = 20
        static let collectionInsets = UIEdgeInsets(
            top: collectionVerticalSpacing,
            left: collectionHorizontalSpacing,
            bottom: collectionVerticalSpacing,
            right: collectionHorizontalSpacing)
    }
    
    var memberList: [MemberResponse] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var didTappedMember: ((MemberResponse) -> ())?
    
    // MARK: - property
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = Size.collectionInsets
        flowLayout.itemSize = CGSize(width: Size.cellLength, height: Size.cellLength)
        flowLayout.minimumInteritemSpacing = Size.cellInteritemSpacingSpacing
        flowLayout.minimumLineSpacing = Size.cellLineSpacing
        return flowLayout
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white200
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsMultipleSelection = true
        collectionView.register(ReflectionMemberCollectionViewCell.self, forCellWithReuseIdentifier: ReflectionMemberCollectionViewCell.className)
        return collectionView
    }()
    
    // MARK: - life cycle
    
    init() {
        super.init(frame: .zero)
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func render() {
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - extension

extension ReflectionMemberCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didTappedMember?(memberList[indexPath.item])
    }
}

extension ReflectionMemberCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memberList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReflectionMemberCollectionViewCell.className, for: indexPath) as? ReflectionMemberCollectionViewCell else {
            assert(false, "Wrong Cell")
            return UICollectionViewCell()
        }
        
        cell.nicknameLabel.text = memberList[indexPath.item].userName
        
        return cell
    }
}
