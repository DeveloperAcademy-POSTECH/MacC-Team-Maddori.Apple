//
//  HomeViewController.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/10/18.
//

import UIKit

import Alamofire
import SnapKit

final class HomeViewController: BaseViewController {
    
    private enum Size {
        static let keywordLabelHeight: CGFloat = 50
        static let propertyPadding: CGFloat = 32
        static let buttonCornerRadius: CGFloat = 27
        static let mainButtonHeight: CGFloat = 54
    }
    
    var keywordList: [String] = TextLiteral.homeViewControllerEmptyCollectionViewList
    var isTouched = false
    
    private var joinReflectionButtonActionIdentifier: UIAction.Identifier = UIAction.Identifier(rawValue: "")
    
    var currentReflectionId: Int = 0
    var reflectionStatus: ReflectionStatus = .Before
    var reflectionTitle: String = ""
    var reflectionDate: String = ""
    
    var isAdmin: Bool = false
    private var currentTeamId: Int = 0
    
    // MARK: - property
    
    private lazy var flowLayout: KeywordCollectionViewFlowLayout = {
        let layout = KeywordCollectionViewFlowLayout()
        layout.count = keywordList.count
        return layout
    }()
    lazy var keywordCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white200
        collectionView.register(KeywordCollectionViewCell.self, forCellWithReuseIdentifier: KeywordCollectionViewCell.className)
        return collectionView
    }()
    private lazy var teamButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .main
        button.setImage(ImageLiterals.icChevronDown, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 13, weight: .semibold), forImageIn: .normal)
        button.tintColor = .black100
        let action = UIAction { [weak self] _ in
            self?.presentTeamModal()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private lazy var teamManageButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.icTeamMananage, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 20), forImageIn: .normal)
        button.tintColor = .gray600
        let action = UIAction { [weak self] _ in
            self?.pushTeamDetailViewController()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private let currentReflectionLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.mainViewControllerCurrentReflectionKeyword
        label.font = .label2
        label.textColor = .black100
        return label
    }()
    private lazy var joinReflectionButton = JoinReflectionButton()
    private lazy var addFeedbackButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white100
        button.setTitle(TextLiteral.mainViewControllerButtonText, for: .normal)
        button.setTitleColor(UIColor.blue200, for: .normal)
        button.titleLabel?.font = .main
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.blue200.cgColor
        button.layer.cornerRadius = Size.buttonCornerRadius
        let action = UIAction { [weak self] _ in
            self?.presentAddFeedbackViewController()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegation()
        render()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLayoutTeamManageButton()
        fetchCertainTeamDetail(type: .fetchCertainTeamDetail)
        fetchCurrentReflectionDetail(type: .fetchCurrentReflectionDetail)
        self.setupNotification()
    }
    
    override func configUI() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white200
    }
    
    override func render() {
        view.addSubview(teamButton)
        teamButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.topPadding)
            $0.height.equalTo(SizeLiteral.minimumTouchArea)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(teamManageButton)
        teamManageButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.topPadding)
            $0.width.height.equalTo(SizeLiteral.minimumTouchArea)
            $0.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(joinReflectionButton)
        joinReflectionButton.snp.makeConstraints {
            $0.top.equalTo(teamButton.snp.bottom).offset(7)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.buttonLeadingTrailingPadding)
        }
        
        view.addSubview(currentReflectionLabel)
        currentReflectionLabel.snp.makeConstraints {
            $0.top.equalTo(joinReflectionButton.snp.bottom).offset(Size.propertyPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(addFeedbackButton)
        addFeedbackButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(SizeLiteral.bottomTabBarPadding)
            $0.height.equalTo(Size.mainButtonHeight)
        }
        
        view.addSubview(keywordCollectionView)
        keywordCollectionView.snp.makeConstraints {
            $0.top.equalTo(currentReflectionLabel.snp.bottom).offset(SizeLiteral.titleSubtitleSpacing)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(addFeedbackButton.snp.top).offset(-10)
        }
    }
    
    // MARK: - func
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadHomeViewController(_:)), name: .changeTeamNotification, object: nil)
    }
    
    private func presentTeamModal() {
        let teamViewController = TeamManageViewController(teamId: self.currentTeamId)
        
        teamViewController.modalPresentationStyle = .pageSheet
        
        if #available(iOS 15.0, *) {
            if let sheet = teamViewController.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.delegate = self
                sheet.prefersGrabberVisible = true
            }
        } else {
            // FIXME: 15 미만일때는 어떻게 해야할지 고민중..
        }
        
        present(teamViewController, animated: true)
    }
    
    private func setupDelegation() {
        keywordCollectionView.delegate = self
        keywordCollectionView.dataSource = self
    }
    
    private func setupJoinReflectionButtonBackground(status: ReflectionStatus) {
        joinReflectionButton.joinButton.removeGradient()
        switch status {
        case .SettingRequired, .Before, .Done:
            joinReflectionButton.joinButton.backgroundColor = .white100
        case .Progressing:
            joinReflectionButton.layoutIfNeeded()
            joinReflectionButton.joinButton.setGradient(colorTop: .gradientBlueTop, colorBottom: .gradientBlueBottom)
            joinReflectionButton.render()
        }
    }
    
    private func setupJoinReflectionButtonAction(status: ReflectionStatus) {
        joinReflectionButton.joinButton.removeAction(identifiedBy: joinReflectionButtonActionIdentifier, for: .touchUpInside)
        let action = UIAction { [weak self] _ in
            switch status {
            case .SettingRequired, .Done:
                self?.presentCreateReflectionViewController()
            case .Before:
                self?.presentEditReflectionViewController()
            case .Progressing:
                self?.presentSelectReflectionMemberViewController()
            }
        }
        joinReflectionButtonActionIdentifier = action.identifier
        joinReflectionButton.joinButton.addAction(action, for: .touchUpInside)
    }
    
    private func presentAddFeedbackViewController() {
        let viewController = UINavigationController(rootViewController: AddFeedbackDetailViewController(feedbackContent: FeedbackContent(toNickName: nil, toUserId: nil, feedbackType: nil, reflectionId: currentReflectionId)))
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
    
    private func presentCreateReflectionViewController() {
        let viewController = UINavigationController(rootViewController: CreateReflectionViewController(reflectionId: currentReflectionId))
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
    
    private func presentEditReflectionViewController() {
        let viewController = UINavigationController(rootViewController: CreateReflectionViewController(reflectionId: currentReflectionId, reflectionTitle: reflectionTitle, reflectionDate: reflectionDate))
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
    
    private func presentSelectReflectionMemberViewController() {
        let viewController = UINavigationController(rootViewController: SelectReflectionMemberViewController(reflectionId: currentReflectionId, isAdmin: self.isAdmin))
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
    
    private func presentStartReflectionView() {
        guard let navigationController = self.navigationController else { return }
        let viewController = StartReflectionViewController(reflectionId: currentReflectionId, navigationViewController: navigationController, isAdmin: self.isAdmin)
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
        UserDefaultHandler.setHasSeenAlert(to: true)
        UserDefaultHandler.clearUserDefaults(of: .seenKeywordIdList)
        UserDefaultHandler.clearUserDefaults(of: .seenMemberIdList)
        UserDefaultHandler.clearUserDefaults(of: .completedCurrentReflection)
    }
    
    private func showAddFeedbackButton() {
        addFeedbackButton.isHidden = false
        keywordCollectionView.snp.remakeConstraints {
            $0.top.equalTo(currentReflectionLabel.snp.bottom).offset(SizeLiteral.titleSubtitleSpacing)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(addFeedbackButton.snp.top).offset(-10)
        }
    }
    
    private func hideAddFeedbackButton() {
        addFeedbackButton.isHidden = true
        keywordCollectionView.snp.remakeConstraints {
            $0.top.equalTo(currentReflectionLabel.snp.bottom).offset(SizeLiteral.titleSubtitleSpacing)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(SizeLiteral.bottomTabBarPadding)
        }
    }
    
    private func convertFetchedKeywordList(of list: [String]) {
        if !list.isEmpty {
            keywordList = []
            for i in 0..<list.count {
                keywordList.append(list[i])
            }
        }
    }
    
    private func resetKeywordList() {
        keywordList = TextLiteral.homeViewControllerEmptyCollectionViewList
    }
    
    private func pushTeamDetailViewController() {
        let viewController = TeamDetailViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func setLayoutTeamManageButton() {
        let hasTeam = UserDefaultStorage.teamId != 0
        teamManageButton.isHidden = !hasTeam
    }
    
    // MARK: - selector
    
    @objc
    private func reloadHomeViewController(_ sender: Notification) {
        if let teamId = sender.object as? Int {
            UserDefaultHandler.setTeamId(teamId: teamId)
            self.fetchCertainTeamDetail(type: .fetchCertainTeamDetail)
            self.fetchCurrentReflectionDetail(type: .fetchCurrentReflectionDetail)
        }
    }
    
    // MARK: - api
    
    private func fetchCertainTeamDetail(type: HomeEndPoint<VoidModel>) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<CertainTeamDetailResponse>.self) { json in
            if let json = json.value {
                guard let isAdmin = json.detail?.admin,
                      let teamName = json.detail?.teamName,
                      let teamId = json.detail?.teamId
                else { return }
                self.isAdmin = isAdmin
                self.currentTeamId = teamId
                DispatchQueue.main.async {
                    self.teamButton.setTitle(teamName + " ", for: .normal)
                }
            } else {
                DispatchQueue.main.async {
                    self.teamButton.setTitle("팀 없음", for: .normal)
                    self.teamButton.tintColor = .gray500
                }
            }
        }
    }
    
    private func fetchCurrentReflectionDetail(type: HomeEndPoint<VoidModel>) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<CurrentReflectionResponse>.self) { json in
            if let json = json.value {
                let reflectionDetail = json.detail
                guard let reflectionStatus = reflectionDetail?.reflectionStatus,
                      let reflectionId = reflectionDetail?.currentReflectionId
                else { return }
                let reflectionTitle = reflectionDetail?.reflectionName ?? ""
                let reflectionDate = reflectionDetail?.reflectionDate ?? ""
                
                self.reflectionStatus = reflectionStatus
                self.currentReflectionId = reflectionId
                self.reflectionTitle = reflectionTitle
                self.reflectionDate = reflectionDate
                self.joinReflectionButton.setupAttribute(reflectionStatus: reflectionStatus, title: reflectionTitle, date: reflectionDate, isPreview: false)
                
                self.setupJoinReflectionButtonAction(status: reflectionStatus)
                self.setupJoinReflectionButtonBackground(status: reflectionStatus)
                
                if let reflectionKeywordList = reflectionDetail?.reflectionKeywords {
                    if reflectionKeywordList.isEmpty {
                        self.resetKeywordList()
                    }
                    self.convertFetchedKeywordList(of: reflectionKeywordList)
                    DispatchQueue.main.async {
                        switch reflectionStatus {
                        case .SettingRequired, .Before, .Done:
                            self.showAddFeedbackButton()
                        case .Progressing:
                            self.hideAddFeedbackButton()
                            if !UserDefaultStorage.hasSeenReflectionAlert {
                                self.presentStartReflectionView()
                            }
                        }
                        self.flowLayout.count = reflectionKeywordList.count
                        self.keywordCollectionView.reloadData()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.joinReflectionButton.setupAttribute(reflectionStatus: .Before, title: "", date: "", isPreview: true)
                    self.setupJoinReflectionButtonBackground(status: .Before)
                }
            }
        }
    }
}

// MARK: - extension

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keywordList.count
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = keywordCollectionView.dequeueReusableCell(withReuseIdentifier: KeywordCollectionViewCell.className, for: indexPath) as? KeywordCollectionViewCell else {
            return UICollectionViewCell()
        }
        let keyword = keywordList[indexPath.item]
        // FIXME: cell을 여기서 접근하는건 안좋은 방법일수도?
        cell.keywordLabel.text = keyword
        cell.configShadow(type: .previewKeyword)
        cell.configLabel(type: .previewKeyword)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIDevice.vibrate()
        switch reflectionStatus {
        case .Before, .SettingRequired, .Done:
            presentAddFeedbackViewController()
        case .Progressing:
            guard let navigationController = self.navigationController else { return }
            let viewController = UINavigationController(rootViewController: SelectReflectionMemberViewController(reflectionId: currentReflectionId, isAdmin: isAdmin))
            viewController.modalPresentationStyle = .fullScreen
            navigationController.present(viewController, animated: true)
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = Size.keywordLabelHeight
        return KeywordCollectionViewCell.fittingSize(availableHeight: size, keyword: keywordList[indexPath.item])
    }
}

extension HomeViewController: UISheetPresentationControllerDelegate {}
