//
//  HomeViewController.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/10/18.
//

import UIKit

import SnapKit

class HomeViewController: BaseViewController {
    
    // MARK: - property
    
    private var keywordCollectionView: UICollectionView!
    static let keywords = mockData
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        registerCell()
        collectionViewDelegate()
    }
    
    // MARK: - func
    
    override func configUI() {
        view.backgroundColor = .white
    }
    
    private func setupCollectionView() {
        keywordCollectionView = UICollectionView(frame: .zero, collectionViewLayout: KeywordCollectionViewLayout.init())
        keywordCollectionView.backgroundColor = .white200
        view.addSubview(keywordCollectionView)
        keywordCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func registerCell() {
        keywordCollectionView.register(KeywordCollectionViewCell.self, forCellWithReuseIdentifier: "KeywordCollectionViewCell")
    }
    
    private func collectionViewDelegate() {
        keywordCollectionView.delegate = self
        keywordCollectionView.dataSource = self
    }
}

// MARK: - extension

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HomeViewController.keywords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = keywordCollectionView.dequeueReusableCell(withReuseIdentifier: "KeywordCollectionViewCell", for: indexPath) as! KeywordCollectionViewCell
        let keyword = HomeViewController.keywords[indexPath.row]
        cell.keywordLabel.text = keyword.string
        // FIXME: cell을 여기서 접근하는건 안좋은 방법일수도?
        cell.configShadow(type: HomeViewController.keywords[indexPath.row].type)
        cell.configLabel(type: HomeViewController.keywords[indexPath.row].type)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = SizeLiteral.keywordLabelHeight
        return KeywordCollectionViewCell.fittingSize(availableHeight: size, keyword: HomeViewController.keywords[indexPath.item].string)
    }
}
