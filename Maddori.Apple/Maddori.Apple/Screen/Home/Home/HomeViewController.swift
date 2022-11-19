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
    var currentReflectionId: Int = 0
    var keywordList: [String] = [
        TextLiteral.homeViewControllerCollectionViewEmtpyText0,
        TextLiteral.homeViewControllerCollectionViewEmtpyText1,
        TextLiteral.homeViewControllerCollectionViewEmtpyText2,
        TextLiteral.homeViewControllerCollectionViewEmtpyText3,
        TextLiteral.homeViewControllerCollectionViewEmtpyText4
    ]
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
    
    // MARK: - property
    
    private let toastView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    private let toastContentView: ToastContentView = {
        let view = ToastContentView()
        view.toastType = .warning
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
    private lazy var planLabelButtonView: LabelButtonView = {
        let labelButton = LabelButtonView()
        labelButton.buttonAction = { [weak self] in
            self?.presentCreateReflectionViewController()
        }
        labelButton.subText = TextLiteral.mainViewControllerPlanLabelButtonSubText
        labelButton.subButtonText = TextLiteral.mainViewControllerPlanLabelButtonSubButtonText
        return labelButton
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
        
        // FIXME: - teamId 와 userId는 일단은 UserDefaults에서 -> 추후에 토큰으로
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
        
        view.addSubview(planLabelButtonView)
        planLabelButtonView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(addFeedbackButton.snp.top)
            $0.height.equalTo(SizeLiteral.minimumTouchArea)
        }
    }
    
    // MARK: - func
    
    private func setUpDelegation() {
        keywordCollectionView.delegate = self
        keywordCollectionView.dataSource = self
    }
    
    private func didTapAddFeedbackButton() {
        let viewController = UINavigationController(rootViewController: SelectFeedbackMemberViewController(currentReflectionId: self.currentReflectionId))
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
    
    private func setGradientToastView() {
        toastView.layoutIfNeeded()
        toastView.setGradient(colorTop: .gradientGrayTop, colorBottom: .gradientGrayBottom)
    }
    
    private func showToastPopUp() {
        if !isTouched {
            isTouched = true
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
    
    private func presentCreateReflectionViewController() {
        let viewController = UINavigationController(rootViewController: CreateReflectionViewController(reflectionId: currentReflectionId))
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
    
    private func showStartReflectionView() {
        let viewController = StartReflectionViewController()
        viewController.modalPresentationStyle = .overFullScreen
        viewController.dismissChildView = { [weak self] in
            self?.dismiss(animated: true)
        }
        present(viewController, animated: true)
        // FIXME: - 모달 띄우고 시작하기만 가능한 건 동작을 너무 제한시킴 -> 추가하기 버튼이 채워지면서 시작하기로 바뀌는건 어떨까?
    }
    
    private func convertFetchedKeywordList(of list: [String]) {
        keywordList = []
        for i in 0..<list.count {
            keywordList.append(list[i])
        }
        print(keywordList)
    }
    
    // MARK: - api
    
    private func fetchCertainTeamDetail(type: HomeEndPoint) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.header
        ).responseDecodable(of: BaseModel<CertainTeamDetailResponse>.self) { json in
            if let json = json.value {
                guard let teamName = json.detail?.teamName else { return }
                DispatchQueue.main.async {
                    self.teamNameLabel.setTitleFont(text: teamName)
                }
            }
        }
    }
    
    private func fetchCurrentReflectionDetail(type: HomeEndPoint) {
        AF.request(type.address,
                   method: type.method,
                   headers: type.header
        ).responseDecodable(of: BaseModel<CurrentReflectionResponse>.self) { json in
            if let json = json.value {
                
                let reflectionDetail = json.detail
                guard let reflectionStatus = reflectionDetail?.reflectionStatus,
                      let reflectionId = reflectionDetail?.currentReflectionId
                else { return }
                
                self.currentReflectionId = reflectionId
                if let reflectionKeywordList = reflectionDetail?.reflectionKeywords {
                    if reflectionKeywordList.count > 0 {
                        self.convertFetchedKeywordList(of: reflectionKeywordList)
                        DispatchQueue.main.async {
                            switch reflectionStatus {
                            case .SettingRequired, .Done:
                                self.descriptionLabel.text = TextLiteral.homeViewControllerEmptyDescriptionLabel
                            case .Before:
                                // FIXME: - 분기 처리 추가
                                let reflectionDate = reflectionDetail?.reflectionDate?.formatDateString(to: "MM월 dd일 a h시 mm분")
                                self.descriptionLabel.text = "다음 회고는 \(reflectionDate ?? String(describing: Date()))입니다"
                            case .Progressing:
                                // FIXME: - 분기 처리 추가
                                let reflectionDate = reflectionDetail?.reflectionDate?.formatDateString(to: "MM월 dd일 a hh시 mm분")
                                self.descriptionLabel.text = "다음 회고는 \(reflectionDate ?? String(describing: Date()))입니다"
                                self.showStartReflectionView()
                            }
                            self.flowLayout.count = reflectionKeywordList.count
                            self.keywordCollectionView.reloadData()
                        }
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
        showToastPopUp()
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = Size.keywordLabelHeight
        return KeywordCollectionViewCell.fittingSize(availableHeight: size, keyword: keywordList[indexPath.item])
    }
}

