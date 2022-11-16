//
//  MyReflectionMainViewController.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/02.
//

import UIKit

import SnapKit

final class MyReflectionViewController: BaseViewController {
    
    private let user = "진저"
    // TODO: reflection 이름 받아온 리스트를 이 totalReflections에 append 시키기
    private let totalReflection = [ReflectionModel(title: "1차 회고", date: "2022.10.30.화"), ReflectionModel(title: "2차 회고", date: "2022.11.07.수"), ReflectionModel(title: "3차 회고", date: "2022.11.21.수")]
//    private let totalReflection: [ReflectionModel] = []
    
    private enum Size {
        static let headerHeight: CGFloat = 50
        static let totalReflectionCellHeight: CGFloat = 70
    }
    
    // MARK: - property
    
    private lazy var myReflectionTitleLabel: UILabel = {
        let label = UILabel()
        label.setTitleFont(text: user + "님의 회고")
        label.applyColor(to: user, with: .blue200)
        return label
    }()
    private let reflectionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white200
        collectionView.register(TotalReflectionCell.self, forCellWithReuseIdentifier: TotalReflectionCell.className)
        collectionView.register(MyReflectionCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MyReflectionCollectionViewHeader.className)
        return collectionView
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegation()
    }
    
    override func render() {
        view.addSubview(myReflectionTitleLabel)
        myReflectionTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(reflectionCollectionView)
        reflectionCollectionView.snp.makeConstraints {
            $0.top.equalTo(myReflectionTitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - func
    
    private func setUpDelegation() {
        reflectionCollectionView.delegate = self
        reflectionCollectionView.dataSource = self
    }
}

// MARK: - extension

extension MyReflectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            UIView.animate(withDuration: 0.15, delay: 0, animations: {
                cell.contentView.backgroundColor = .gray100
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            UIView.animate(withDuration: 0.15, delay: 0, animations: {
                cell.contentView.backgroundColor = .white200
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(MyReflectionDetailViewController(), animated: true)
    }
}

extension MyReflectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if totalReflection.isEmpty {
            collectionView.setEmptyReflectionView()
        } else {
            collectionView.restore()
        }
        return totalReflection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyReflectionCollectionViewHeader.className, for: indexPath) as? MyReflectionCollectionViewHeader else { return UICollectionReusableView() }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: Size.totalReflectionCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TotalReflectionCell.className, for: indexPath) as? TotalReflectionCell else { return UICollectionViewCell() }
        cell.configLabel(text: totalReflection[indexPath.item].title, date: totalReflection[indexPath.item].date)
        return cell
    }
}

extension MyReflectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: Size.headerHeight)
    }
}
