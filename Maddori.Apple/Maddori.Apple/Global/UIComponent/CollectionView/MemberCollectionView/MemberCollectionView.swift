//
//  MemberCollectionView.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/10/19.
//

import UIKit

import SnapKit

final class MemberCollectionView: UIView {
    
    // FIXME: - 목업 데이터 추후 데이터 연결한 후 삭제할 내용
    
    var memberList: [MemberResponse] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var didTappedMember: (([String]) -> ())?
    private var selectedMemberList: [String] = []
    private enum Size {
        static let collectionHorizontalSpacing: CGFloat = 14
        static let collectionTopSpacing: CGFloat = 40
        static let cellWidth: CGFloat = 135
        static let cellHeight: CGFloat = 60
        static let collectionInsets = UIEdgeInsets(
            top: collectionTopSpacing,
            left: collectionHorizontalSpacing,
            bottom: 0,
            right: collectionHorizontalSpacing)
    }
    
    // MARK: - property
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = Size.collectionInsets
        flowLayout.itemSize = CGSize(width: Size.cellWidth, height: Size.cellHeight)
        flowLayout.minimumLineSpacing = 29
        return flowLayout
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MemberCollectionViewCell.self, forCellWithReuseIdentifier: MemberCollectionViewCell.className)
        return collectionView
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        if !selectedMemberList.contains(memberList[indexPath.item].username ?? "") {
            selectedMemberList.append(memberList[indexPath.item].username ?? "")
        }
        didTappedMember?(selectedMemberList)
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
        cell.memberLabel.text = memberList[indexPath.item].username
        return cell
    }
}
