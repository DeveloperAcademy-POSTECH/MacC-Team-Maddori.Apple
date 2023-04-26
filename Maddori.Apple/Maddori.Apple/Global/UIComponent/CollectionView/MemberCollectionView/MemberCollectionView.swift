//
//  MemberCollectionView.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/10/19.
//

import UIKit

import SnapKit

final class MemberCollectionView: UIView {
    
    private enum Size {
        static let collectionHorizontalSpacing: CGFloat = 20
        static let collectionVerticalSpacing: CGFloat = 4
        static let cellWidth: CGFloat = 133
        static let cellHeight: CGFloat = 52
        static let cellSpacing: CGFloat = 20
        static let collectionInsets: UIEdgeInsets = UIEdgeInsets(
            top: collectionVerticalSpacing,
            left: collectionHorizontalSpacing,
            bottom: collectionVerticalSpacing,
            right: collectionHorizontalSpacing)
    }
    
    var memberList: [MemberDetailResponse] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var didTappedFeedBackMember: ((MemberDetailResponse) -> ())?
    var selectedMember: MemberDetailResponse?
    
    // MARK: - property
    
    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = Size.collectionInsets
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - SizeLiteral.leadingTrailingPadding * 2 - 38, height: 52)
        flowLayout.minimumLineSpacing = Size.cellSpacing
        return flowLayout
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .white200
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MemberCollectionViewCell.self, forCellWithReuseIdentifier: MemberCollectionViewCell.className)
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

extension MemberCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedMember = memberList[indexPath.item]
        guard let member = selectedMember else { return }
        didTappedFeedBackMember?(member)
    }
}

extension MemberCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memberList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemberCollectionViewCell.className, for: indexPath) as? MemberCollectionViewCell else {
            assert(false, "Wrong Cell")
            return UICollectionViewCell()
        }
        if let username = memberList[indexPath.item].userName {
            cell.setupLayoutInfoView(nickname: username, role: memberList[indexPath.item].role ?? "", imagePath: memberList[indexPath.item].profileImagePath)
        }
        return cell
    }
}
