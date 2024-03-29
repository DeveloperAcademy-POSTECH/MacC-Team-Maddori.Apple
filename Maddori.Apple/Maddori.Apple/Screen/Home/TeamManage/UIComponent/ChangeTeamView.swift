//
//  ChangeTeamView.swift
//  Maddori.Apple
//
//  Created by 이성호 on 2023/02/06.
//

import UIKit

import SnapKit

protocol ChangeTeamViewDelegate: AnyObject {
    func changeTeam(teamId: Int)
}

final class ChangeTeamView: UIView {
    
    var teamList: [TeamNameResponse] = [] {
        didSet {
            self.teamList.isEmpty ? self.setLayoutEmptyView() : self.setLayoutTeamListView()
        }
    }
    var currentTeamId: Int?
    weak var delegate: ChangeTeamViewDelegate?
    
    // MARK: - property
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .label2
        label.text = TextLiteral.changeTeamViewLabel
        label.textColor = .black100
        return label
    }()
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 12, left: 0 , bottom: 16, right: 0)
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - SizeLiteral.leadingTrailingPadding * 2, height: 59)
        flowLayout.minimumLineSpacing = 8
        return flowLayout
    }()
    lazy var teamCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TeamChangeCollectionViewCell.self, forCellWithReuseIdentifier: TeamChangeCollectionViewCell.className)
        collectionView.backgroundColor = .white200
        return collectionView
    }()
    private lazy var emptyView = EmptyTeamView()
    
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
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(34)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
    }
    
    // MARK: - function
    
    private func setLayoutTeamListView() {
        self.addSubview(teamCollectionView)
        teamCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }
    
    private func setLayoutEmptyView() {
        self.addSubview(emptyView)
        emptyView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(28)
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(150)
        }
    }
}

extension ChangeTeamView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.teamList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamChangeCollectionViewCell.className, for: indexPath) as? TeamChangeCollectionViewCell else { return UICollectionViewCell() }
        cell.teamNameLabel.text = self.teamList[indexPath.item].teamName
        if let currentTeamId = self.currentTeamId {
            if self.teamList[indexPath.item].id == currentTeamId {
                cell.isSelected = true
            }
        }
        
        return cell
    }
}

extension ChangeTeamView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let teamId = self.teamList[indexPath.item].id,
              let nickname = self.teamList[indexPath.item].nickname
        else { return }
        self.delegate?.changeTeam(teamId: teamId)
        UserDefaultHandler.setNickname(nickname: nickname)
    }
}
