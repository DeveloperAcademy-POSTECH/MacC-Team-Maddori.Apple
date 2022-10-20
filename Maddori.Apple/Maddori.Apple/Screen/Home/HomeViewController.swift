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
    private var keywordCollectionView: KeywordCollectionView!
    private let keywords = mockData
    
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
    
    override func render() {
        
    }
    
    private func setupCollectionView() {
        keywordCollectionView = KeywordCollectionView(frame: .zero, collectionViewLayout: KeywordCollectionViewLayout.init())
        keywordCollectionView.backgroundColor = .systemGray
        view.addSubview(keywordCollectionView)
        keywordCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(24)
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

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keywords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = keywordCollectionView.dequeueReusableCell(withReuseIdentifier: "KeywordCollectionViewCell", for: indexPath) as! KeywordCollectionViewCell
        cell.keywordLabel.text = keywords[indexPath.row].keyword
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return KeywordCollectionViewCell.fittingSize(availableHeight: 45, keyword: keywords[indexPath.item].keyword)
        }
}
