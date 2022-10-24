//
//  InProgressViewController.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/10/24.
//

import UIKit

import SnapKit

final class InProgressViewController: BaseViewController {
    
    fileprivate var keywordData = Keyword.mockData
    fileprivate let currentRetrospective = "진저"
    fileprivate let user = "이드"
//    private let user = "진저"
    private let headerId = "headerId"
    private enum Size {
        static let keywordLabelHeight: CGFloat = 50
    }
    private var keywords = [[Keyword]]()
    
    // MARK: - properties
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "awefdasf"
        return label
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.setTitleFont(text: currentRetrospective +  TextLiteral.InProgressViewControllerTitleLabel)
        label.textColor = .black100
        label.numberOfLines = 0
        return label
    }()
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .caption1
        label.textColor = .gray400
        if user == currentRetrospective {
            label.text = currentRetrospective + TextLiteral.InProgressViewControllerSubTitleLabel
        } else {
            label.text = currentRetrospective + TextLiteral.InProgressViewControllerOthersSubTitleLabel
        }
        label.numberOfLines = 0
        return label
    }()
    private lazy var keywordCollectionView: UICollectionView = {
        let flowLayout = KeywordCollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white200
        collectionView.register(KeywordCollectionViewCell.self,
                                forCellWithReuseIdentifier: KeywordCollectionViewCell.className)
        collectionView.register(SectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeaderView.className)
        return collectionView
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegation()
        setUpKeywordType()
    }
    
    // MARK: - func
    
    override func render() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(SizeLiteral.titleSubTitlePadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(keywordCollectionView)
        keywordCollectionView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    fileprivate func checkIfUserRetrospective() -> Bool {
        return user == currentRetrospective ? true : false
    }
    
    private func setUpDelegation() {
        keywordCollectionView.delegate = self
        keywordCollectionView.dataSource = self
    }
    
    private func setUpKeywordType() {
        if checkIfUserRetrospective() {
            for i in 0..<keywordData.count {
                keywordData[i].type = .defaultKeyword
            }
            keywords.append(keywordData)
        } else {
            var myKeywords = keywordData.filter { $0.from == user}
            var otherKeywords = keywordData.filter { $0.from != user}
            for i in 0..<myKeywords.count {
                myKeywords[i].type = .defaultKeyword
            }
            for j in 0..<otherKeywords.count {
                otherKeywords[j].type = .subKeyword
            }
            keywords.append(myKeywords)
            keywords.append(otherKeywords)
        }
    }
}

// MARK: - extension

extension InProgressViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return keywords[0].count
        case 1:
            return keywords[1].count
        default:
            return keywords[0].count
        }
    }
}

extension InProgressViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if checkIfUserRetrospective() {
            return 1
        } else {
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.className, for: indexPath) as? SectionHeaderView else { return UICollectionReusableView() }
        
        if checkIfUserRetrospective() {
            header.label.text = TextLiteral.InProgressViewControllerReceivedLabel
        } else if indexPath.section == 0 {
            header.label.text = TextLiteral.InProgressViewControllerGivenLabel
        } else if indexPath.section == 1 {
            header.label.text = TextLiteral.InProgressViewControllerOtherGivenLabel
        }
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = keywordCollectionView.dequeueReusableCell(withReuseIdentifier: KeywordCollectionViewCell.className, for: indexPath) as? KeywordCollectionViewCell else {
            return UICollectionViewCell()
        }
        let section = indexPath.section
        let item = indexPath.item
        let keyword = keywords[section][item]
        cell.keywordLabel.text = keyword.string
        cell.configShadow(type: keyword.type)
        cell.configLabel(type: keyword.type)
        return cell
    }
}

extension InProgressViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = indexPath.section
        let item = indexPath.item
        let size = Size.keywordLabelHeight
        return KeywordCollectionViewCell.fittingSize(availableHeight: size, keyword: keywords[section][item].string)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
}

