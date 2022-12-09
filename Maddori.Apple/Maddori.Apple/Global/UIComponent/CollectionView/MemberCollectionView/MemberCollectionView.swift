//
//  MemberCollectionView.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/10/19.
//

import UIKit

import SnapKit

final class MemberCollectionView: UIView {
    
    enum CollectionType {
        case addFeedback
        case progressReflection
        
        var collectionHorizontalSpacing: CGFloat {
            switch self {
            case .addFeedback:
                return 20
            case .progressReflection:
                return 14
            }
        }
        
        var collectionTopSpacing: CGFloat {
            switch self {
            case .addFeedback:
                return 10
            case .progressReflection:
                return 40
            }
        }
        
        var cellWidth: CGFloat {
            switch self {
            case .addFeedback:
                return 133
            case .progressReflection:
                return 135
            }
        }
        
        var cellHeight: CGFloat {
            switch self {
            case .addFeedback:
                return 52
            case .progressReflection:
                return 60
            }
        }
        
        var collectionInsets: UIEdgeInsets {
            switch self {
            case .addFeedback:
                return UIEdgeInsets(
                    top: collectionTopSpacing,
                    left: collectionHorizontalSpacing,
                    bottom: 0,
                    right: collectionHorizontalSpacing)
            case .progressReflection:
                return UIEdgeInsets(
                    top: collectionTopSpacing,
                    left: collectionHorizontalSpacing,
                    bottom: 20,
                    right: collectionHorizontalSpacing)
            }
        }
    }
    
    var type: CollectionType
    var currentToUserId = 0
    var memberList: [MemberResponse] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var didTappedMember: (([MemberResponse]) -> ())?
    var didTappedFeedBackMember: ((MemberResponse) -> ())?
    var selectedMember: MemberResponse?
    private var selectedMemberList: [MemberResponse] = []
    
    // MARK: - property
    
    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = type.collectionInsets
        flowLayout.itemSize = CGSize(width: type.cellWidth, height: type.cellHeight)
        flowLayout.minimumLineSpacing = 29
        return flowLayout
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .white100
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MemberCollectionViewCell.self, forCellWithReuseIdentifier: MemberCollectionViewCell.className)
        return collectionView
    }()
    
    // MARK: - life cycle
    
    init(type: CollectionType) {
        self.type = type
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
        switch type {
        case .addFeedback:
            selectedMember = memberList[indexPath.item]
            guard let member = selectedMember else { return }
            didTappedFeedBackMember?(member)
            
        case .progressReflection:
            if !selectedMemberList.contains(where: { $0.userName == memberList[indexPath.item].userName} ) {
                selectedMemberList.append(memberList[indexPath.item])
            }
            guard let cell = collectionView.cellForItem(at: indexPath) as? MemberCollectionViewCell else { return }
            selectedMember = memberList[indexPath.item]
            guard let member = selectedMember else { return }
            cell.setupAttribute()
            didTappedMember?(selectedMemberList)
            didTappedFeedBackMember?(member)
        }
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
        cell.memberLabel.text = memberList[indexPath.item].userName
        
        switch type {
        case .addFeedback:
            cell.index = FromCellIndex.fromAddFeedback
        case .progressReflection:
            cell.index = FromCellIndex.fromSelectMember
        }
        return cell
    }
}


enum FromCellIndex {
    case fromAddFeedback
    case fromSelectMember
}
