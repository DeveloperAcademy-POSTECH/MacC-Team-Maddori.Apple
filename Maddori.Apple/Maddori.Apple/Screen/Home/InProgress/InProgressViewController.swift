//
//  InProgressViewController.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/10/24.
//

import UIKit

import Alamofire
import SnapKit

final class InProgressViewController: BaseViewController {
    
    private var keywordData = Keyword.mockData
    private let currentRetrospectiveUser = "진저"
    private let user = "이드"
//    private let user = "진저"
    private enum Size {
        static let keywordLabelHeight: CGFloat = 50
        static let sectionPadding: CGFloat = 60
        static let myReflectionEmptyViewHeight: CGFloat = 500
        static let othersReflectionEmptyViewHeight: CGFloat = 180
    }
    private var keywordsSectionList: [[Keyword]] = []
    private var isUserRetrospective: Bool {
        return user == currentRetrospectiveUser ? true : false
    }
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.setTitleFont(text: currentRetrospectiveUser + TextLiteral.inProgressViewControllerTitleLabel)
        label.textColor = .black100
        return label
    }()
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .caption1
        label.textColor = .gray400
        if user == currentRetrospectiveUser {
            label.text = currentRetrospectiveUser + TextLiteral.inProgressViewControllerSubTitleLabel
        } else {
            label.text = currentRetrospectiveUser + TextLiteral.inProgressViewControllerOthersSubTitleLabel
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
        collectionView.register(EmptyFeedbackView.self, forCellWithReuseIdentifier: EmptyFeedbackView.className)
        collectionView.register(KeywordSectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: KeywordSectionHeaderView.className)
        return collectionView
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegation()
        setUpKeywordType()
        fetchTeamAndUserFeedback(type: .fetchTeamAndUserFeedback(reflectionId: 67, teamId: 63, memberId: 122, userId: 123))
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
    
    // MARK: - api
    
    private func fetchTeamAndUserFeedback(type: InProgressEndPoint) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.header
        ).responseDecodable(of: BaseModel<AllFeedBackResponse>.self) { json in
            dump(json)
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
        let sectionIsEmpty = keywordsSectionList[section].isEmpty
        if sectionIsEmpty {
            return 1
        } else {
            switch section {
            case 0:
                return keywordsSectionList[0].count
            case 1:
                return keywordsSectionList[1].count
            default:
                return keywordsSectionList[0].count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KeywordSectionHeaderView.className, for: indexPath) as? KeywordSectionHeaderView else { return UICollectionReusableView() }
        if isUserRetrospective {
            header.label.text = TextLiteral.inProgressViewControllerReceivedLabel
        } else if indexPath.section == 0 {
            header.label.text = TextLiteral.inProgressViewControllerGivenLabel
        } else if indexPath.section == 1 {
            header.label.text = TextLiteral.inProgressViewControllerOtherGivenLabel
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
        guard let emptyCell = keywordCollectionView.dequeueReusableCell(withReuseIdentifier: EmptyFeedbackView.className, for: indexPath) as? EmptyFeedbackView else {
            return UICollectionViewCell()
        }
        
        let section = indexPath.section
        let item = indexPath.item
        let sectionIsEmpty = keywordsSectionList[section].isEmpty
        
        if sectionIsEmpty && !isUserRetrospective {
            switch section {
            case 0:
                emptyCell.emptyFeedbackLabel.text = TextLiteral.emptyViewInProgressOthersRetrospectiveSelf
            case 1:
                emptyCell.emptyFeedbackLabel.text = TextLiteral.emptyViewInProgressOthersRetrospectiveOthers
            default:
                return emptyCell
            }
            return emptyCell
        } else if sectionIsEmpty && isUserRetrospective {
            emptyCell.emptyFeedbackLabel.text = TextLiteral.emptyViewInProgressMyRetrospective
            return emptyCell
        }
        
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
        let sectionIsEmpty = keywordsSectionList[section].isEmpty
        if sectionIsEmpty && isUserRetrospective {
            return CGSize(width: view.frame.width - 2 * SizeLiteral.leadingTrailingPadding, height: Size.myReflectionEmptyViewHeight)
        } else if sectionIsEmpty && !isUserRetrospective {
            return CGSize(width: view.frame.width - 2 * SizeLiteral.leadingTrailingPadding, height: Size.othersReflectionEmptyViewHeight)
        }
        return KeywordCollectionViewCell.fittingSize(availableHeight: Size.keywordLabelHeight,
                                                     keyword: keywordsSectionList[section][item].string)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: Size.sectionPadding)
    }
}

