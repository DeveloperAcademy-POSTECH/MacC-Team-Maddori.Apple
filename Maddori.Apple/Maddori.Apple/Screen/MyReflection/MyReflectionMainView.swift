//
//  MyReflectionMainView.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/02.
//

import UIKit

import SnapKit

final class MyReflectionMainViewController: BaseViewController {
    
    private let user = "진저"
    // TODO: reflection 이름 받아온 리스트를 이 reflectionSections에 append 시키기
    private let specialSection = ["즐겨찾기"]
    private let reflectionSection = [ReflectionModel(title: "1차 회고", date: "2022.10.30.화"),
                                     ReflectionModel(title: "2차 회고", date: "2022.11.07.수"),
                                     ReflectionModel(title: "3차 회고", date: "2022.11.21.수")]
    private enum Size {
        static let headerHeight: CGFloat = 50
        static let specialCellHeight: CGFloat = 50
        static let collectionCellHeight: CGFloat = 70
    }
    
    // MARK: - property
    
    private lazy var myReflectionTitle: UILabel = {
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
        collectionView.register(ReflectionCollectionViewSpecialCell.self, forCellWithReuseIdentifier: ReflectionCollectionViewSpecialCell.className)
        collectionView.register(ReflectionCollectionViewCollectionCell.self, forCellWithReuseIdentifier: ReflectionCollectionViewCollectionCell.className)
        collectionView.register(ReflectionCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ReflectionCollectionViewHeader.className)
        return collectionView
    }()
    
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegation()
    }
    
    // MARK: - func
    
    override func render() {
        view.addSubview(myReflectionTitle)
        myReflectionTitle.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(reflectionCollectionView)
        reflectionCollectionView.snp.makeConstraints {
            $0.top.equalTo(myReflectionTitle.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setUpDelegation() {
        reflectionCollectionView.delegate = self
        reflectionCollectionView.dataSource = self
    }
}

extension MyReflectionMainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            UIView.animate(withDuration: 0.15, delay: 0, animations: {
                cell.contentView.backgroundColor = .gray100
            }) { _ in
                UIView.animate(withDuration: 0.15, delay: 0, animations: {
                    cell.contentView.backgroundColor = .white200
                })
            }
        }
    }
}

extension MyReflectionMainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return specialSection.count
        case 1:
            return reflectionSection.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = indexPath.section
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ReflectionCollectionViewHeader.className, for: indexPath) as? ReflectionCollectionViewHeader else { return UICollectionReusableView() }
        switch section {
        case 0:
            header.configIcon(to: .special)
            header.configLabel(to: .special)
        case 1:
            header.configIcon(to: .reflection)
            header.configLabel(to: .reflection)
        default:
            return UICollectionReusableView()
        }
        return header
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 2 * SizeLiteral.leadingTrailingPadding
        let section = indexPath.section
        switch section {
        case 0:
            return CGSize(width: width, height: Size.specialCellHeight)
        case 1:
            return CGSize(width: width, height: Size.collectionCellHeight)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReflectionCollectionViewSpecialCell.className, for: indexPath) as? ReflectionCollectionViewSpecialCell else { return UICollectionViewCell()}
            cell.configLabel(text: specialSection[indexPath.item])
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReflectionCollectionViewCollectionCell.className, for: indexPath) as? ReflectionCollectionViewCollectionCell else { return UICollectionViewCell() }
            cell.configLabel(text: reflectionSection[indexPath.item].title,
                             date: reflectionSection[indexPath.item].date)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension MyReflectionMainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: Size.headerHeight)
    }
}
