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
        static let propertyPadding: CGFloat = 40
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
    
    private let toastView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    private let toastContentView: ToastContentView = {
        let view = ToastContentView()
        view.toastType = .complete
        return view
    }()
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
    private lazy var teamNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black100
        label.numberOfLines = 0
        return label
    }()
    private let invitationCodeButton: UIButton = {
         let button = UIButton()
         button.setTitle(TextLiteral.mainViewControllerInvitationButtonText, for: .normal)
         button.setTitleColor(UIColor.blue200, for: .normal)
         button.titleLabel?.font = .caption2
         button.backgroundColor = .gray100
         button.layer.cornerRadius = 4
         return button
     }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .caption1
        label.textColor = .gray400
        return label
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchCertainTeamDetail(type: .fetchCertainTeamDetail)
        fetchCurrentReflectionDetail(type: .fetchCurrentReflectionDetail)
    }
    
    override func configUI() {
        view.backgroundColor = .white200
        setGradientToastView()
    }
    
    override func render() {
        navigationController?.view.addSubview(toastView)
        toastView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(-60)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(46)
        }
        
        toastView.addSubview(toastContentView)
        toastContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        toastContentView.render()
        
        view.addSubview(teamNameLabel)
        teamNameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(invitationCodeButton)
        invitationCodeButton.snp.makeConstraints {
           $0.leading.equalTo(teamNameLabel.snp.trailing).offset(Size.labelButtonPadding)
           $0.width.equalTo(Size.subButtonWidth)
           $0.height.equalTo(Size.subButtonHeight)
           $0.bottom.equalTo(teamNameLabel.snp.bottom).offset(-5)
        }
        
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(teamNameLabel.snp.bottom).offset(SizeLiteral.titleSubtitleSpacing)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(currentReflectionLabel)
        currentReflectionLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(Size.propertyPadding)
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
    
    private func setGradientToastView() {
        toastView.layoutIfNeeded()
        toastView.setGradient(colorTop: .gradientGrayTop, colorBottom: .gradientGrayBottom)
    }
    
    private func setGradientJoinReflectionView() {
        joinReflectionButton.layoutIfNeeded()
        joinReflectionButton.setGradient(colorTop: .gradientBlueTop, colorBottom: .gradientBlueBottom)
    }
    
    private func showToastPopUp(of type: ToastType) {
        if !isTouched {
            isTouched = true
            DispatchQueue.main.async {
                self.toastContentView.toastType = type
            }
            UIView.animate(withDuration: 0.5, delay: 0, animations: {
                self.toastView.transform = CGAffineTransform(translationX: 0, y: 115)
            }, completion: {_ in
                UIView.animate(withDuration: 1, delay: 0.8, animations: {
                    self.toastView.transform = .identity
                }, completion: {_ in
                    self.isTouched = false
                })
            })
        }
    }
    
    private func setupCopyCodeButton(code: String) {
        let action = UIAction { [weak self] _ in
            UIPasteboard.general.string = code
            self?.showToastPopUp(of: .complete)
        }
        invitationCodeButton.addAction(action, for: .touchUpInside)
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
    }
    
    private func showJoinReflectionButton() {
        view.addSubview(joinReflectionButton)
        joinReflectionButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        currentReflectionLabel.snp.remakeConstraints {
            $0.top.equalTo(joinReflectionButton.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        keywordCollectionView.snp.remakeConstraints {
            $0.top.equalTo(currentReflectionLabel.snp.bottom).offset(SizeLiteral.titleSubtitleSpacing)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-SizeLiteral.bottomTabBarPadding)
        }
        
        setGradientJoinReflectionView()
        joinReflectionButton.render()
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
        currentReflectionLabel.snp.remakeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(Size.propertyPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
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
                      let teamName = json.detail?.teamName,
                      let invitationCode = json.detail?.invitationCode
                else { return }
                self.isAdmin = isAdmin
                DispatchQueue.main.async {
                    self.teamNameLabel.setTitleFont(text: teamName)
                    self.setupCopyCodeButton(code: invitationCode)
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
                            self.descriptionLabel.text = TextLiteral.homeViewControllerEmptyDescriptionLabel
                            self.addFeedbackButton.isHidden = false
                            self.hideJoinReflectionButton()
                            self.showPlanLabelButton()
                            self.restoreView()
                        case .Before:
                            let reflectionDate = reflectionDetail?.reflectionDate?.formatDateString(to: "M월 d일 a h시 m분")
                            self.descriptionLabel.text = "다음 회고는 \(reflectionDate ?? String(describing: Date()))입니다"
                            self.hidePlanLabelButton()
                        case .Progressing:
                            let reflectionDate = reflectionDetail?.reflectionDate?.formatDateString(to: "M월 d일 a h시 m분")
                            self.descriptionLabel.text = "다음 회고는 \(reflectionDate ?? String(describing: Date()))입니다"
                            self.showJoinReflectionButton()
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
            if hasKeyword {
                showToastPopUp(of: .warning)
            } else {
                didTapAddFeedbackButton()
            }
            
        case .Progressing:
            showStartReflectionView()
        }
        
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = Size.keywordLabelHeight
        return KeywordCollectionViewCell.fittingSize(availableHeight: size, keyword: keywordList[indexPath.item])
    }
}

