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
    
    private var currentReflectionMemberId: Int
    private var currentReflectionMemberName: String
    private var currentReflectionId: Int
    
    private let userId = UserDefaultStorage.userId
    private let teamId = UserDefaultStorage.teamId
    
    private var userKeywordData: [Keyword] = []
    private var teamKeywordData: [Keyword] = []
    
    private var keywordsSectionList: [[Keyword]] = [[], []] {
        didSet {
            keywordCollectionView.reloadData()
            setUpKeywordType()
        }
    }
    private var isUserRetrospective: Bool {
        return userId == currentReflectionMemberId ? true : false
    }
    
    init(memberId: Int, memberUsername: String, reflectionId: Int) {
        self.currentReflectionMemberId = memberId
        self.currentReflectionMemberName = memberUsername
        self.currentReflectionId = reflectionId
        super.init()
    }
    
    required init?(coder: NSCoder) { nil }
    
    // MARK: - property
    
    private lazy var backButton: BackButton = {
        let button = BackButton()
        let action = UIAction { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
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
        label.setLineSpacing(to: 2)
        return label
    }()
    private let flowLayout = KeywordCollectionViewFlowLayout()
    private lazy var keywordCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white200
        collectionView.register(KeywordCollectionViewCell.self,
                                forCellWithReuseIdentifier: KeywordCollectionViewCell.className)
        collectionView.register(EmptyCollectionFeedbackView.self, forCellWithReuseIdentifier: EmptyCollectionFeedbackView.className)
        collectionView.register(KeywordSectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: KeywordSectionHeaderView.className)
        return collectionView
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTeamAndUserFeedback(type: .fetchTeamAndUserFeedback(
            reflectionId: currentReflectionId,
            memberId: currentReflectionMemberId
            )
        )
        setUpDelegation()
    }
    
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
    
    // MARK: - setup
    
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
                teamKeywordData[i].style = UserDefaultStorage.seenKeywordIdList.contains(teamKeywordData[i].id) ? .disabledKeyword : .defaultKeyword
            }
        } else {
            for i in 0..<userKeywordData.count {
                userKeywordData[i].style = UserDefaultStorage.seenKeywordIdList.contains(userKeywordData[i].id) ? .disabledKeyword : .defaultKeyword
            }
            for j in 0..<teamKeywordData.count {
                teamKeywordData[j].style = UserDefaultStorage.seenKeywordIdList.contains(teamKeywordData[j].id) ? .disabledKeyword : .subKeyword
            }
        }
    }
    
    // MARK: - func
    
    private func convert(_ response: [FeedBackContentResponse]) -> [Keyword] {
        var keywordList: [Keyword] = []
        for feedback in response {
            let keyword = Keyword(
                id: feedback.id ?? 0,
                type: feedback.type ?? .continueType,
                keyword: feedback.keyword ?? "키워드",
                content: feedback.content ?? "",
                // FIXME: startContent가 없을 경우 "" 로 둬도 될까?
                startContent: feedback.startContent ?? "",
                fromUser: feedback.fromUser?.userName ?? "팀원"
            )
            keywordList.append(keyword)
        }
        return keywordList
    }
    
    private func presentDetailView(feedbackInfo: ReflectionInfoModel) {
        let viewController = InProgressDetailViewController(feedbackInfo: feedbackInfo)
        self.present(viewController, animated: true)
    }
    
    // MARK: - api
    
    private func fetchTeamAndUserFeedback(type: InProgressEndPoint<VoidModel>) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<AllFeedBackResponse>.self) { json in
            if let json = json.value {
                guard let userFeedbackList = json.detail?.userFeedback,
                      let teamFeedbackList = json.detail?.teamFeedback
                else { return }
                
                self.userKeywordData = self.convert(userFeedbackList)
                self.teamKeywordData = self.convert(teamFeedbackList)
                
                self.setUpKeywordType()
                if self.isUserRetrospective {
                    self.keywordsSectionList[0] = self.teamKeywordData
                } else {
                    self.keywordsSectionList[0] = self.userKeywordData
                    self.keywordsSectionList[1] = self.teamKeywordData
                }
                self.flowLayout.count = self.keywordsSectionList.flatMap { $0 }.count
            }
        }
    }
}

// MARK: - extension

extension InProgressViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = keywordCollectionView.cellForItem(at: indexPath) as? KeywordCollectionViewCell else { return }
        let keyword = keywordsSectionList[indexPath.section][indexPath.item]
        guard let startContent = keyword.startContent else { return }
        let feedbackInfo = ReflectionInfoModel(
            nickname: keyword.fromUser,
            feedbackType: keyword.type,
            keyword: keyword.keyword,
            info: keyword.content, start: startContent
        )
        UserDefaultHandler.appendSeenKeywordIdList(keywordId: keyword.id)
        DispatchQueue.main.async {
            cell.setupAttribute(to: .disabledKeyword)
            self.presentDetailView(feedbackInfo: feedbackInfo)
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
        guard let emptyCell = keywordCollectionView.dequeueReusableCell(withReuseIdentifier: EmptyCollectionFeedbackView.className, for: indexPath) as? EmptyCollectionFeedbackView else {
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
        cell.setupAttribute(to: keyword.style ?? .defaultKeyword)
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
        return KeywordCollectionViewCell.fittingSize(
            availableHeight: Size.keywordLabelHeight,
            keyword: keywordsSectionList[section][item].keyword
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: Size.sectionPadding)
    }
}

