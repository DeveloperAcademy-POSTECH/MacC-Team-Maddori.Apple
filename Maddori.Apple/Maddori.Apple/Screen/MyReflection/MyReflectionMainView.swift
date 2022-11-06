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
    // TODO: reflection 이름 받아온 리스트를 이 totalReflections에 append 시키기
    // totalReflection 위아래 바꿔가면서 테스트 해볼 수 있습니다
//    private let totalReflection = [ReflectionModel(title: "1차 회고", date: "2022.10.30.화"), ReflectionModel(title: "2차 회고", date: "2022.11.07.수"), ReflectionModel(title: "3차 회고", date: "2022.11.21.수")]
    private let totalReflection: [ReflectionModel] = []
    
    private enum Size {
        static let headerHeight: CGFloat = 50
        static let totalReflectionCellHeight: CGFloat = 70
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
        collectionView.register(TotalReflectionCell.self, forCellWithReuseIdentifier: TotalReflectionCell.className)
        collectionView.register(ReflectionCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ReflectionCollectionViewHeader.className)
        return collectionView
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegation()
    }
    
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
        
//        view.addSubview(emptyFeedbackLabel)
//        emptyFeedbackLabel.snp.makeConstraints {
//            $0.top.equalTo(reflectionCollectionView.snp.bottom)
//            $0.centerX.equalToSuperview()
//            $0.width.equalTo(88)
//            $0.height.equalTo(54)
//        }
    }
    
    // MARK: - func
    
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if totalReflection.count == 0 {
            collectionView.setEmptyReflectionView()
        } else {
            collectionView.restore()
        }
        return totalReflection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ReflectionCollectionViewHeader.className, for: indexPath) as? ReflectionCollectionViewHeader else { return UICollectionReusableView() }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 2 * SizeLiteral.leadingTrailingPadding
        return CGSize(width: width, height: Size.totalReflectionCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TotalReflectionCell.className, for: indexPath) as? TotalReflectionCell else { return UICollectionViewCell()}
        cell.configLabel(text: totalReflection[indexPath.item].title, date: totalReflection[indexPath.item].date)
        return cell
    }
}

extension MyReflectionMainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: Size.headerHeight)
    }
}
