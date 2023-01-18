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
    
    var keywordList: [String] = TextLiteral.homeViewControllerEmptyCollectionViewList
    var isTouched = false
    
    private enum Size {
        static let keywordLabelHeight: CGFloat = 50
        static let labelButtonPadding: CGFloat = 6
        static let propertyPadding: CGFloat = 32
        static let buttonCornerRadius: CGFloat = 27
        static let mainButtonHeight: CGFloat = 54
        static let subButtonWidth: CGFloat = 54
        static let subButtonHeight: CGFloat = 20
        static let planReflectionViewHeight: CGFloat = 40
    }
    
    var currentReflectionId: Int = 0
    var reflectionStatus: ReflectionStatus = .Before
    var hasKeyword: Bool = false
    var isAdmin: Bool = false
    var hasSeenReflectionAlert: Bool = UserDefaultStorage.hasSeenReflectionAlert {
        willSet {
            UserDefaultHandler.setHasSeenAlert(to: newValue)
        }
    }
    
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
        let button = UIButton()
        let action = UIAction { _ in
            // FIXME: 버튼 눌렀을 때 action 추가
            print("touched")
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private lazy var teamNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black100
        label.font = .main
        label.numberOfLines = 0
        return label
    }()
    private let arrowDownImageView: UIImageView = {
        let image = UIImageView(image: ImageLiterals.icChevronDown)
        image.tintColor = .black100
        return image
    }()
    private lazy var teamManageButton: UIButton = {
        let button = UIButton()
        let action = UIAction { _ in
            // FIXME: 버튼 눌렀을 때 action 추가
            print("touched")
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private let teamManageImageView: UIImageView = {
        let image = UIImageView(image: ImageLiterals.icTeamMananage)
        image.tintColor = .gray600
        return image
    }()
    private let currentReflectionLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.mainViewControllerCurrentReflectionKeyword
        label.font = .label2
        label.textColor = .black100
        return label
    }()
    private lazy var joinReflectionButton: JoinReflectionButton = {
        let joinButton = JoinReflectionButton()
        joinButton.layer.cornerRadius = 10
        joinButton.clipsToBounds = true
        joinButton.buttonAction = { [weak self] in
            self?.presentSelectReflectionMemberViewController()
        }
        return joinButton
    }()
    private lazy var planLabelButtonView: LabelButtonView = {
        let labelButton = LabelButtonView()
        labelButton.buttonAction = { [weak self] in
            self?.presentCreateReflectionViewController()
        }
        labelButton.subText = TextLiteral.mainViewControllerPlanLabelButtonSubText
        labelButton.subButtonText = TextLiteral.mainViewControllerPlanLabelButtonSubButtonText
        return labelButton
    }()
    private let planLabelButtonBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundWhite
        return view
    }()
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
            self?.didTapAddFeedbackButton()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegation()
        render()
        setGradientJoinReflectionView()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if reflectionStatus == .Progressing && !hasSeenReflectionAlert {
            showStartReflectionView()
        }
        fetchCertainTeamDetail(type: .fetchCertainTeamDetail)
        fetchCurrentReflectionDetail(type: .fetchCurrentReflectionDetail)
    }
    
    override func configUI() {
        view.backgroundColor = .white200
    }
    
    override func render() {
        view.addSubview(teamButton)
        teamButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.topPadding)
            $0.height.equalTo(SizeLiteral.minimumTouchArea)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        teamButton.addSubview(teamNameLabel)
        teamNameLabel.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
        }
        
        teamButton.addSubview(arrowDownImageView)
        arrowDownImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(teamNameLabel.snp.trailing).offset(4)
            $0.trailing.equalTo(teamButton)
        }
        
        view.addSubview(teamManageButton)
        teamManageButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.topPadding)
            $0.width.height.equalTo(SizeLiteral.minimumTouchArea)
            $0.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        teamManageButton.addSubview(teamManageImageView)
        teamManageImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.height.equalTo(30)
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
    
    private func setUpDelegation() {
        keywordCollectionView.delegate = self
        keywordCollectionView.dataSource = self
    }
    
    private func renderPlanLabelButton() {
        view.addSubview(planLabelButtonBackgroundView)
        planLabelButtonBackgroundView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(addFeedbackButton.snp.top)
            $0.height.equalTo(SizeLiteral.minimumTouchArea)
        }
        
        planLabelButtonBackgroundView.addSubview(planLabelButtonView)
        planLabelButtonView.snp.makeConstraints {
            $0.top.bottom.centerX.equalToSuperview()
        }
    }
    
    private func didTapAddFeedbackButton() {
        let viewController = UINavigationController(rootViewController: AddFeedbackDetailViewController(feedbackContent: FeedbackContent(toNickName: nil, toUserId: nil, feedbackType: nil, reflectionId: currentReflectionId)))
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
    
    private func setGradientJoinReflectionView() {
        joinReflectionButton.layoutIfNeeded()
        joinReflectionButton.setGradient(colorTop: .gradientBlueTop, colorBottom: .gradientBlueBottom)
        joinReflectionButton.render()
    }
    
    private func presentCreateReflectionViewController() {
        let viewController = UINavigationController(rootViewController: CreateReflectionViewController(reflectionId: currentReflectionId))
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
    
    private func presentSelectReflectionMemberViewController() {
        let viewController = UINavigationController(rootViewController: SelectReflectionMemberViewController(reflectionId: currentReflectionId, isAdmin: self.isAdmin))
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
    
    
    // 회고 상태: Setting Required
    private func showPlanLabelButton() {
        planLabelButtonView.isHidden = false
        planLabelButtonBackgroundView.isHidden = false
    }
    
    // 회고 상태: Before
    private func hidePlanLabelButton() {
        planLabelButtonView.isHidden = true
        planLabelButtonBackgroundView.isHidden = true
        
        keywordCollectionView.snp.remakeConstraints {
            $0.top.equalTo(currentReflectionLabel.snp.bottom).offset(SizeLiteral.titleSubtitleSpacing)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(addFeedbackButton.snp.top).offset(-10)
        }
    }
    
    // 회고 상태: Progressing
    private func showStartReflectionView() {
        guard let navigationController = self.navigationController else { return }
        let viewController = StartReflectionViewController(reflectionId: currentReflectionId, navigationViewController: navigationController, isAdmin: self.isAdmin)
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
        hasSeenReflectionAlert = true
        UserDefaultHandler.clearUserDefaults(of: .seenKeywordIdList)
        UserDefaultHandler.clearUserDefaults(of: .seenMemberIdList)
        UserDefaultHandler.clearUserDefaults(of: .completedCurrentReflection)
    }
    
    private func hideAddFeedbackButton() {
        self.addFeedbackButton.isHidden = true
        keywordCollectionView.snp.remakeConstraints {
            $0.top.equalTo(currentReflectionLabel.snp.bottom).offset(SizeLiteral.titleSubtitleSpacing)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(SizeLiteral.bottomTabBarPadding)
        }
    }
    
    // 회고 상태: Done
    private func restoreView() {
        if isAdmin {
            keywordCollectionView.snp.remakeConstraints {
                $0.top.equalTo(currentReflectionLabel.snp.bottom).offset(SizeLiteral.titleSubtitleSpacing)
                $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
                $0.bottom.equalTo(planLabelButtonBackgroundView.snp.top).offset(-10)
            }
        }
    }
    
    private func hideJoinReflectionButton() {
        joinReflectionButton.removeFromSuperview()
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
    
    // MARK: - api
    
    private func fetchCertainTeamDetail(type: HomeEndPoint<VoidModel>) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.headers
        ).responseDecodable(of: BaseModel<CertainTeamDetailResponse>.self) { json in
            if let json = json.value {
                guard let isAdmin = json.detail?.admin,
                      let teamName = json.detail?.teamName
                else { return }
                self.isAdmin = isAdmin
                DispatchQueue.main.async {
                    self.teamNameLabel.text = teamName
                    if isAdmin {
                        self.renderPlanLabelButton()
                    }
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
                
                self.currentReflectionId = reflectionId
                self.reflectionStatus = reflectionStatus
                if let reflectionKeywordList = reflectionDetail?.reflectionKeywords {
                    self.hasKeyword = true
                    if reflectionKeywordList.isEmpty {
                        self.resetKeywordList()
                        self.hasKeyword = false
                    }
                    self.convertFetchedKeywordList(of: reflectionKeywordList)
                    DispatchQueue.main.async {
                        switch reflectionStatus {
                        case .SettingRequired, .Done:
                            self.addFeedbackButton.isHidden = false
                            self.hideJoinReflectionButton()
                            self.showPlanLabelButton()
                            self.restoreView()
                        case .Before:
                            self.hidePlanLabelButton()
                        case .Progressing:
                            self.hidePlanLabelButton()
                            self.hideAddFeedbackButton()
                            if !self.hasSeenReflectionAlert {
                                self.showStartReflectionView()
                            }
                        }
                        self.flowLayout.count = reflectionKeywordList.count
                        self.keywordCollectionView.reloadData()
                    }
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
            didTapAddFeedbackButton()
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

