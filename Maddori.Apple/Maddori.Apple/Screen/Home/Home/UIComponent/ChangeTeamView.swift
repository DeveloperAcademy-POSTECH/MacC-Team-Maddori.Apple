//
//  ChangeTeamView.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2023/02/06.
//

import UIKit

import SnapKit

final class ChangeTeamView: UIView {
    
    // MARK: - FIXME: 데이터 더미 입니다.
    private let teamDataDummy: [String] = ["맛쟁이 사과처럼", "굿굿이에요", "테스트더미에요"]
    
    // MARK: - property
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .label2
        label.text = "참여 중인 팀"
        label.textColor = .black100
        return label
    }()
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 12, left: SizeLiteral.leadingTrailingPadding, bottom: 16, right: SizeLiteral.leadingTrailingPadding)
        flowLayout.itemSize = CGSize(width: 335, height: 59)
        flowLayout.minimumLineSpacing = 8
        return flowLayout
    }()
    private lazy var teamCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TeamChangeCollectionViewCell.self, forCellWithReuseIdentifier: TeamChangeCollectionViewCell.className)
        collectionView.backgroundColor = .white200
        return collectionView
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configUI()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func configUI() {
        self.backgroundColor = .white200
    }
    
    private func render() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(26)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        self.addSubview(teamCollectionView)
        teamCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }
    
    // MARK: - function
    

    
}

extension ChangeTeamView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teamDataDummy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamChangeCollectionViewCell.className, for: indexPath) as? TeamChangeCollectionViewCell else { return UICollectionViewCell() }
        cell.teamNameLabel.text = teamDataDummy[indexPath.item]
        return cell
    }
    
    
}

extension ChangeTeamView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // MARK: - FIXME
        let selectedTeamName = teamDataDummy[indexPath.item]
        print(selectedTeamName)
    
    }
}
