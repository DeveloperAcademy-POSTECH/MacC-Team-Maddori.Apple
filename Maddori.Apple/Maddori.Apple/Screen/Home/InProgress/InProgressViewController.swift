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
    
    private enum Size {
        static let keywordLabelHeight: CGFloat = 50
        static let sectionPadding: CGFloat = 60
        static let myReflectionEmptyViewHeight: CGFloat = 500
        static let othersReflectionEmptyViewHeight: CGFloat = 180
    }
    
    private var userKeywordData: [Keyword] = [] {
        didSet {
            keywordCollectionView.reloadData()
        }
    }
    private var teamKeywordData: [Keyword] = [] {
        didSet {
            keywordCollectionView.reloadData()
        }
    }
    
    private var currentReflectionMemberName: String
    private var currentReflectionMemberId: Int
    private var userId: Int = 5
    
    private var keywordsSectionList: [[Keyword]] = []
    private var isUserRetrospective: Bool {
        return userId == currentReflectionMemberId ? true : false
    }
    
//    private let user = "이드"
    
    init(memberId: Int, memberUsername: String) {
        self.currentReflectionMemberId = memberId
        self.currentReflectionMemberName = memberUsername
        super.init()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.setTitleFont(text: currentReflectionMemberName + TextLiteral.inProgressViewControllerTitleLabel)
        label.textColor = .black100
        return label
    }()
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .caption1
        label.textColor = .gray400
        if isUserRetrospective {
            label.text = currentReflectionMemberName + TextLiteral.inProgressViewControllerSubTitleLabel
        } else {
            label.text = currentReflectionMemberName + TextLiteral.inProgressViewControllerOthersSubTitleLabel
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
        fetchTeamAndUserFeedback(type: .fetchTeamAndUserFeedback(teamId: 1, reflectionId: 2, memberId: currentReflectionMemberId, userId: userId))
        print(currentReflectionMemberId)
        print(userId)
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
            for i in 0..<teamKeywordData.count {
                teamKeywordData[i].style = .defaultKeyword
            }
        } else {
            for i in 0..<userKeywordData.count {
                userKeywordData[i].style = .defaultKeyword
            }
            for j in 0..<teamKeywordData.count {
                teamKeywordData[j].style = .subKeyword
            }
        }
    }
    
    private func convert(_ response: [FeedBackContentResponse]) -> [Keyword] {
        var keywordList: [Keyword] = []
        for feedback in response {
            let keyword = Keyword(
                type: feedback.type ?? "Continue",
                keyword: feedback.keyword ?? "키워드",
                content: feedback.content ?? "",
                startContent: feedback.startContent ?? "",
                fromUser: feedback.fromUser?.username ?? "팀원"
            )
            keywordList.append(keyword)
        }
        return keywordList
    }
    
    // MARK: - api
    
    private func fetchTeamAndUserFeedback(type: InProgressEndPoint) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<AllFeedBackResponse>.self) { json in
            if let json = json.value {
                dump(json)
                guard let userFeedbackList = json.detail?.userFeedback else { return }
                guard let teamFeedbackList = json.detail?.teamFeedback else { return }
                self.userKeywordData = self.convert(userFeedbackList)
                self.teamKeywordData = self.convert(teamFeedbackList)
                
                if self.isUserRetrospective {
                    self.keywordsSectionList.append(self.teamKeywordData)
                } else {
                    self.keywordsSectionList.append(self.userKeywordData)
                    self.keywordsSectionList.append(self.teamKeywordData)
                }
                print(self.keywordsSectionList)
            }
        }
    }
}

// MARK: - extension

extension InProgressViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = keywordCollectionView.dequeueReusableCell(withReuseIdentifier: KeywordCollectionViewCell.className, for: indexPath) as? KeywordCollectionViewCell else { return }
        let section = indexPath.section
        let item = indexPath.item
        keywordsSectionList[section][item].style = .disabledKeyword
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
        cell.keywordLabel.text = keyword.keyword
        cell.configLabel(type: keyword.style ?? .defaultKeyword)
        cell.configShadow(type: keyword.style ?? .defaultKeyword)
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
                                                     keyword: keywordsSectionList[section][item].keyword)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: Size.sectionPadding)
    }
}

