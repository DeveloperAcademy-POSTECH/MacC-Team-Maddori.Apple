//
//  FavoriteCollectionView.swift
//  Maddori.Apple
//
//  Created by LeeSungHo on 2022/11/03.
//

import UIKit

import SnapKit

final class FavoriteCollectionView: UIView {
    private enum Size {
        static let horizontalPadding: CGFloat = SizeLiteral.leadingTrailingPadding
        static let topSpacing: CGFloat = SizeLiteral.topComponentPadding
        static let cellWitdh: CGFloat = UIScreen.main.bounds.width - (SizeLiteral.leadingTrailingPadding * 2)
        static let cellHeight: CGFloat = 70
        static let collectionViewInset = UIEdgeInsets.init(top: Size.topSpacing, left: Size.horizontalPadding, bottom: 0, right: Size.horizontalPadding)
    }
    
    // MARK: - property
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = Size.collectionViewInset
        flowLayout.itemSize = CGSize(width: Size.cellWitdh, height: Size.cellHeight)
        return flowLayout
    }()
    private lazy var favoriteCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .backgroundWhite
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FavoriteReflectionCell.self, forCellWithReuseIdentifier: FavoriteReflectionCell.className)
        return collectionView
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func render() {
        self.addSubview(favoriteCollectionView)
        favoriteCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension FavoriteCollectionView: UICollectionViewDelegate { }

extension FavoriteCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteReflectionCell.className, for: indexPath) as? FavoriteReflectionCell else { return UICollectionViewCell() }
        return cell
    }
}
