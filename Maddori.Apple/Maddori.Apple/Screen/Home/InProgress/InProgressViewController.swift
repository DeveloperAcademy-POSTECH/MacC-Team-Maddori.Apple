//
//  InProgressViewController.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/10/24.
//

import UIKit

import SnapKit

final class InProgressViewController: BaseViewController {
    
    private var keywordData = Keyword.mockData
    private let currentRetrospectiveUser = "진저"
//    private let user = "이드"
    private let user = "진저"
    private enum Size {
        static let keywordLabelHeight: CGFloat = 50
        static let sectionPadding: CGFloat = 60
    }
    private var keywordsSectionList: [[Keyword]] = []
    private var isUserRetrospective: Bool {
        return user == currentRetrospectiveUser ? true : false
    }
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.setTitleFont(text: currentRetrospectiveUser + TextLiteral.InProgressViewControllerTitleLabel)
        label.textColor = .black100
        return label
    }()
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .caption1
        label.textColor = .gray400
        if user == currentRetrospectiveUser {
            label.text = currentRetrospectiveUser + TextLiteral.InProgressViewControllerSubTitleLabel
        } else {
            label.text = currentRetrospectiveUser + TextLiteral.InProgressViewControllerOthersSubTitleLabel
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
            $0.top.equalTo(titleLabel.snp.bottom).offset(SizeLiteral.titleSubtitleSpacing)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(keywordCollectionView)
        keywordCollectionView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        // FIXME: - 터치영역 34로 되어있음
        let button = removeBarButtonItemOffset(with: backButton, offsetX: 10)
        let backButton = makeBarButtonItem(with: button)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setUpDelegation() {
        keywordCollectionView.delegate = self
        keywordCollectionView.dataSource = self
    }
    
    private func setUpKeywordType() {
        if isUserRetrospective {
            for i in 0..<keywordData.count {
                keywordData[i].type = .defaultKeyword
            }
            keywordsSectionList.append(keywordData)
        } else {
            var myKeywords = keywordData.filter { $0.from == user}
            var otherKeywords = keywordData.filter { $0.from != user}
            for i in 0..<myKeywords.count {
                myKeywords[i].type = .defaultKeyword
            }
            for j in 0..<otherKeywords.count {
                otherKeywords[j].type = .subKeyword
            }
            keywordsSectionList.append(myKeywords)
            keywordsSectionList.append(otherKeywords)
        }
    }
}

// MARK: - extension

extension InProgressViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = keywordCollectionView.dequeueReusableCell(withReuseIdentifier: KeywordCollectionViewCell.className, for: indexPath) as? KeywordCollectionViewCell else { return }
        let section = indexPath.section
        let item = indexPath.item
        keywordsSectionList[section][item].type = .disabledKeyword
        DispatchQueue.main.async {
            UIView.performWithoutAnimation {
                cell.configLabel(type: .disabledKeyword)
                cell.configShadow(type: .disabledKeyword)
                self.keywordCollectionView.reloadItems(at: [indexPath])
            }
        }
    }
}

extension InProgressViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if isUserRetrospective {
            return 1
        } else {
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return keywordsSectionList[0].count
        case 1:
            return keywordsSectionList[1].count
        default:
            return keywordsSectionList[0].count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.className, for: indexPath) as? SectionHeaderView else { return UICollectionReusableView() }
        if isUserRetrospective {
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
        let keyword = keywordsSectionList[section][item]
        cell.keywordLabel.text = keyword.string
        cell.configLabel(type: keyword.type)
        cell.configShadow(type: keyword.type)
        return cell
    }
}

extension InProgressViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = indexPath.section
        let item = indexPath.item
        let size = Size.keywordLabelHeight
        return KeywordCollectionViewCell.fittingSize(availableHeight: size, keyword: keywordsSectionList[section][item].string)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 100, height: Size.sectionPadding)
    }
}

