//
//  HomeViewController.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/10/18.
//

import UIKit

import SnapKit

class HomeViewController: BaseViewController {
    
    static let keywords = mockData
    static let isAdmin: Bool = true
    
    // MARK: - property
    
    private enum Size {
        static let keywordLabelHeight: CGFloat = 50
        // FIXME: 기존 간격인 10으로 하면
        static let labelPadding: CGFloat = 5
        static let labelButtonPadding: CGFloat = 6
        static let propertyPadding: CGFloat = 40
        static let buttonCornerRadius: CGFloat = 27
        static let mainButtonHeight: CGFloat = 54
        static let subButtonWidth: CGFloat = 54
        static let subButtonHeight: CGFloat = 20
        static let planReflectionViewHeight: CGFloat = 40
    }
    
    private var keywordCollectionView: UICollectionView!
    private let planReflectionView = UIView()
    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.mainViewControllerTeamName
        label.font = .title
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
        label.text = TextLiteral.mainViewControllerReflectionDateDescription
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
    private let planReflectionViewLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.mainViewControllerPlanReflectionViewLabelText
        label.font = .body2
        label.textColor = .gray400
        return label
    }()
    private let planReflectionViewButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextLiteral.mainViewControllerPlanReflectionViewButtonText, for: .normal)
        button.titleLabel?.font = .body2
        button.setTitleColor(UIColor.blue200, for: .normal)
        // TODO: button action 추가
        return button
    }()
    private let addFeedbackButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white100
        button.setTitle(TextLiteral.mainViewControllerButtonText, for: .normal)
        button.setTitleColor(UIColor.blue200, for: .normal)
        button.titleLabel?.font = .main
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.blue200.cgColor
        button.layer.cornerRadius = Size.buttonCornerRadius
        // TODO: button action 추가
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        registerCell()
        collectionViewDelegate()
    }
    
    // MARK: - func
    
    override func configUI() {
        view.backgroundColor = .backgroundWhite
    }
    
    override func render() {
        view.addSubview(teamNameLabel)
        teamNameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(invitationCodeButton)
        invitationCodeButton.snp.makeConstraints {
            $0.leading.equalTo(teamNameLabel.snp.trailing).offset(Size.labelButtonPadding)
            $0.width.equalTo(Size.subButtonWidth)
            $0.height.equalTo(Size.subButtonHeight)
            $0.bottom.equalTo(teamNameLabel.snp.bottom).offset(-5)
            // offset을 없애면 너무 낮은 것 같다는 생각에 임의로 줘봤습니다
        }
        
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(teamNameLabel.snp.bottom).offset(Size.labelPadding)
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
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(SizeLiteral.bottomPadding)
            $0.height.equalTo(Size.mainButtonHeight)
        }
        
        planReflectionView.addSubview(planReflectionViewLabel)
        planReflectionViewLabel.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
        }
        planReflectionView.addSubview(planReflectionViewButton)
        planReflectionViewButton.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview()
            $0.leading.equalTo(planReflectionViewLabel.snp.trailing).offset(4)
        }
        view.addSubview(planReflectionView)
        planReflectionView.snp.makeConstraints {
            $0.bottom.equalTo(addFeedbackButton.snp.top)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Size.planReflectionViewHeight)
        }
        
    }
    
    private func setupCollectionView() {
        keywordCollectionView = UICollectionView(frame: .zero, collectionViewLayout: KeywordCollectionViewLayout.init())
        keywordCollectionView.backgroundColor = .white200
        view.addSubview(keywordCollectionView)
        keywordCollectionView.snp.makeConstraints {
            $0.top.equalTo(currentReflectionLabel.snp.bottom).offset(Size.labelPadding)
            $0.leading.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(planReflectionView.snp.top)
        }
    }
    
    private func registerCell() {
        keywordCollectionView.register(KeywordCollectionViewCell.self, forCellWithReuseIdentifier: "KeywordCollectionViewCell")
    }
    
    private func collectionViewDelegate() {
        keywordCollectionView.delegate = self
        keywordCollectionView.dataSource = self
    }
}

// MARK: - extension

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HomeViewController.keywords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = keywordCollectionView.dequeueReusableCell(withReuseIdentifier: "KeywordCollectionViewCell", for: indexPath) as! KeywordCollectionViewCell
        let keyword = HomeViewController.keywords[indexPath.row]
        cell.keywordLabel.text = keyword.string
        // FIXME: cell을 여기서 접근하는건 안좋은 방법일수도?
        cell.configShadow(type: HomeViewController.keywords[indexPath.row].type)
        cell.configLabel(type: HomeViewController.keywords[indexPath.row].type)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = Size.keywordLabelHeight
        return KeywordCollectionViewCell.fittingSize(availableHeight: size, keyword: HomeViewController.keywords[indexPath.item].string)
    }
}
